# Gary Dalton's Documentations

Documents I have written covering how-tos, tutorials, support, and technical documents.

Visit [Werkspc.com](https://werkspc.com/)



## Running locally

The dev container pins Hugo to the same version as `render-build.sh` and runs the one-time setup on create. If you're setting up by hand, run this once first:

```bash
git config --global --add safe.directory "$(pwd)"   # enableGitInfo needs git to trust the repo
npm ci                                              # PostCSS toolchain
```

Then, from the repo root:

```bash
hugo server -D --watch --poll 700ms --bind 0.0.0.0 --liveReloadPort=1313
```

- Open <http://localhost:1313>. VS Code forwards port 1313 from the container; if not, add it in the **Ports** tab.
- `-D` shows drafts locally. Render never builds drafts, so this is safe.
- Edits reload the browser automatically. Stop with `Ctrl+C`.

Deploys happen on push to `master`: Render runs `bash render-build.sh`. There is no local production build step.
