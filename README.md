# imagefy!

A minimal "image repository". Users can register and upload images with titles, tags, and descriptions, as well as setting access controls on a per-image basis. Open images are indexed on the homepage stream of images for all users, unlisted images are viewable to all with a direct link, secret images are only visible to the uploader.

Unregistered users can still view the image stream and view direct links to images, as well as take advantage of the surprise feature, taking them to a random open image!

## Local development

Ruby 3 and Rails 6. Install Docker (Compose), which makes it trivial to set up and run this project (web application and Postgres database) with `docker-compose up` after cloning. The web application will be on port 3000, the database on 5432.

## Environment variables

Although the default engine for ActiveStorage locally is just the local filesystem, if you wish to use AWS S3, then make sure the relevant variables are defined in a `.env` file in the root repository directory:

```
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_REGION=
AWS_BUCKET=
```

If deploying, make sure to fill out the `DATABASE_URL` variable as well.

## Ideation

- Searching by tags
- Alternate stream views e.g. grid