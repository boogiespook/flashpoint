<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

$commandFile = '/tmp/war-game-command.txt';
$lockFile = '/tmp/war-game-command.lock';

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// POST: Set a command
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $command = isset($_POST['command']) ? $_POST['command'] :
               (isset($_GET['command']) ? $_GET['command'] :
               file_get_contents('php://input'));

    if (!empty($command)) {
        // Acquire lock
        $lock = fopen($lockFile, 'w');
        flock($lock, LOCK_EX);

        // Write command with timestamp
        file_put_contents($commandFile, json_encode([
            'command' => trim($command),
            'timestamp' => time()
        ]));

        // Release lock
        flock($lock, LOCK_UN);
        fclose($lock);

        echo json_encode(['status' => 'success', 'command' => trim($command)]);
    } else {
        http_response_code(400);
        echo json_encode(['status' => 'error', 'message' => 'No command provided']);
    }
}

// GET: Retrieve and clear command
elseif ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (file_exists($commandFile)) {
        // Acquire lock
        $lock = fopen($lockFile, 'w');
        flock($lock, LOCK_EX);

        $data = json_decode(file_get_contents($commandFile), true);

        // Clear the command file
        unlink($commandFile);

        // Release lock
        flock($lock, LOCK_UN);
        fclose($lock);

        // Only return commands less than 10 seconds old
        if ($data && (time() - $data['timestamp']) < 10) {
            echo json_encode(['status' => 'success', 'command' => $data['command']]);
        } else {
            echo json_encode(['status' => 'success', 'command' => null]);
        }
    } else {
        echo json_encode(['status' => 'success', 'command' => null]);
    }
}

// DELETE: Clear command queue
elseif ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    if (file_exists($commandFile)) {
        unlink($commandFile);
    }
    echo json_encode(['status' => 'success', 'message' => 'Command queue cleared']);
}

else {
    http_response_code(405);
    echo json_encode(['status' => 'error', 'message' => 'Method not allowed']);
}
?>
