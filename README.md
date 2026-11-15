# scrapbooking-pink-corvid

Source for <https://notes.corvid.garden>, a notes blog built with Jekyll. GitHub Actions builds it and publishes it to GitHub Pages.

## Writing workflow

1. Start the preview with `docker compose up -d`.
2. Open `http://<this-machine>:4000` from any device on the LAN.
3. Write a post in `_posts/YYYY-MM-DD-title.md`. Saving rebuilds the site and refreshes the browser.
4. When it looks right, commit and push to `main`. The Action in `.github/workflows/pages.yml` builds and publishes it, usually within a minute or two. You can follow the run in the repo's Actions tab.

The Action and the preview container install from the same `Gemfile.lock`, so the preview matches the live site. The only differences are the local-only parts described below.

## Preview commands

| To… | Run |
|---|---|
| start | `docker compose up -d` |
| watch the build log | `docker compose logs -f` |
| stop | `docker compose down` |
| rebuild after changing `Gemfile` or `Dockerfile` | `docker compose up -d --build` |
| pick up a change to `_config.yml` or `_config.local.yml` | `docker compose restart` |

Changes to posts, layouts and CSS are picked up automatically. Config changes are not.

## Local-only notebook

`_notebook/`, `notebook/` and `_config.local.yml` are git-ignored and exist only on the preview machine. `_config.local.yml` adds the notebook to the preview, gives notebook pages a distinct "unpublished" style, and shows a **LOCAL PREVIEW** bar on every page. None of this reaches the live site.

To publish a note, move it from `_notebook/` into `_posts/`, adding a date to the filename.

## Before pushing

- **Pushing is publishing.** Whatever reaches `main` goes live, and stays in the git history even if it's removed later.
- **The notebook is protected only by `.gitignore`.** `git add -f` would override it.
- **Photos:** nothing strips EXIF or GPS data yet, so check images before committing them.

## Versions

Versions are pinned in `.ruby-version`, `Gemfile.lock` and the `Dockerfile`'s `FROM` line. Keep the Ruby version in `.ruby-version` and the `Dockerfile` the same. To update the gems, run `docker compose run --rm preview bundle lock --update`, which rewrites `Gemfile.lock`. Then rebuild with `docker compose up -d --build`.
