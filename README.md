# Home Lab GitOps

This repository contains the GitOps configuration for managing a personal Kubernetes home lab cluster. It uses a prototype-based approach where reusable application blueprints (`prototypes/`) are configured and instantiated by specific environments (`envs/`).

## Tooling

*   **GitOps Rendering:** [Myks](https://github.com/mykso/myks)
*   **GitOps Orchestration:** ArgoCD
*   **Templating:** Carvel `ytt`
*   **Package Management:** Helm & Carvel `vendir`
*   **Secret Management:** HashiCorp Vault with `argocd-vault-plugin`
*   **Deployment:** Manifests are deployed via ArgoCD.

## Scripts

The `scripts/` directory contains helper utilities for managing application data.

*   `immich_sort.sh`: Sorts photos into year-based directories using EXIF data.
*   `immich_upload.sh`: Uploads a directory of photos to an Immich instance.

## Vault OIDC

Discovery URL: https://keycloak.duchardt.net/auth/realms/master

```
vault write auth/oidc/role/admin \
      bound_audiences="vault" \                           
      allowed_redirect_uris="https://vault.duchardt.net/ui/vault/auth/oidc/oidc/callback" \
      allowed_redirect_uris="https://vault.duchardt.net/oidc/callback" \
      user_claim="sub" \
      token_policies="admin"
```

## Automation TODOs

- Paperless-nx
- Starbase80
