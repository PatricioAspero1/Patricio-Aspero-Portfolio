# Public Repository Sanitization Notice

The scripts and configuration examples in this section are sanitized versions
of tools currently used within my personal homelab.

They are published to demonstrate the structure, logic, and automation behind
my projects without exposing information that could unnecessarily reveal or
provide access to my infrastructure.

## What Has Been Sanitized

Public versions may replace or remove:

- Internal IP addresses
- Public endpoints
- Hostnames where appropriate
- Usernames
- API keys
- Discord webhook URLs
- Authentication credentials
- SSH-related information
- VPN configuration
- Environment-specific paths or identifiers
- Other security-sensitive configuration

Values shown in `.env.example` and other example configuration files are
placeholders and do not represent active credentials or production
configuration.

---

## Differences From Production

The scripts published here may differ slightly from the versions currently
running in my homelab.

For example, a production script may reference an internal system directly:

```text
Internal Host → Monitoring Service
```

While the public version may instead use a configurable environment variable:

```bash
PROMETHEUS_URL="${PROMETHEUS_URL:-}"
```

This preserves the underlying logic and functionality of the project while
keeping the actual environment configuration private.

---

## Security Approach

Where possible, the public versions also demonstrate practices I am working
toward using throughout the production environment, including:

- Separating configuration from application logic
- Keeping secrets outside source code
- Using environment variables for deployment-specific values
- Limiting automated administrative permissions
- Restricting automated recovery to explicitly approved systems
- Maintaining human oversight of higher-impact automation

---

## About the Published Code

The code in this repository is intended to demonstrate my work, projects,
and continued learning.

It should not be interpreted as a complete copy of my production configuration
or as documentation of the exact addressing, authentication, or security
controls used within my homelab.

Some values, names, addresses, paths, and configuration examples may be
modified, generalized, or replaced with placeholders for public release.

The infrastructure shown throughout this portfolio follows the same principle:
enough technical detail is provided to explain what I built, how the components
interact, and what I learned while building them, while credentials and
unnecessary security-sensitive implementation details remain private.

---

## Responsible Use

These scripts were created for use within my own controlled homelab
environment.

Anyone reviewing the source should evaluate and adapt the configuration,
permissions, error handling, and security controls before attempting to use
similar automation within another environment.

Automation involving administrative access or service recovery should be
tested carefully before being used with production or critical systems.

---

[← Back to Scripts & Automation](README.md)
