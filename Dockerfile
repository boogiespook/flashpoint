# Multi-stage build for production-ready container
FROM registry.access.redhat.com/ubi9/php-83:latest

# Metadata
LABEL maintainer="FLASHPOINT Security Response Platform" \
      version="2.4.0" \
      description="FLASHPOINT - Automated Security Response in Action. Interactive demonstration and training platform featuring: (1) Demo Mode - 6 fully automated security incident response workflows with sound effects and dark/light themes, (2) Learning Mode - Interactive drag-and-drop workflow builder for hands-on training. Use cases: Supply Chain CVE Remediation, Compliance Response, Infrastructure Patching, Secret Sprawl Detection, Certificate Renewal, and Cloud Misconfiguration Remediation."

# Set working directory
WORKDIR /opt/app-root/src

# Install system dependencies
USER root
RUN dnf install -y \
    httpd \
    php-fpm \
    php-json \
    && dnf clean all \
    && rm -rf /var/cache/dnf

# Configure Apache for security
RUN sed -i 's/^ServerTokens .*/ServerTokens Prod/' /etc/httpd/conf/httpd.conf && \
    sed -i 's/^ServerSignature .*/ServerSignature Off/' /etc/httpd/conf/httpd.conf && \
    echo 'Header always set X-Content-Type-Options "nosniff"' >> /etc/httpd/conf/httpd.conf && \
    echo 'Header always set X-Frame-Options "SAMEORIGIN"' >> /etc/httpd/conf/httpd.conf && \
    echo 'Header always set X-XSS-Protection "1; mode=block"' >> /etc/httpd/conf/httpd.conf

# Copy application files
COPY --chown=1001:0 index.html ./
COPY --chown=1001:0 api.php ./
COPY --chown=1001:0 trigger.html ./
COPY --chown=1001:0 README.md ./
COPY --chown=1001:0 workflow ./

# Create tmp directory for API command storage
RUN mkdir -p /tmp && \
    chmod 1777 /tmp

# Set proper permissions
RUN chown -R 1001:0 /opt/app-root/src && \
    chmod -R g=u /opt/app-root/src && \
    chmod 755 /opt/app-root/src

# Switch back to non-root user
USER 1001

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

# Expose port
EXPOSE 8080

# Use PHP built-in server for lightweight deployment
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/opt/app-root/src"]
