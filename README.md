# imagefy!

<img alt="Screenshot of the interface" src="https://github.com/javanag/imagefy/assets/12960997/f73b27b0-9be6-4b66-b123-e9c1035f5a35" height="500">

A minimal "image repository". Users can register and upload images with titles, tags, and descriptions, as well as setting access controls on a per-image basis. Open images are indexed on the homepage stream of images for all users, unlisted images are viewable to all with a direct link, secret images are only visible to the uploader.

Unregistered and registered users alike users can view the image stream and view direct links to images, as well as take advantage of the surprise feature, taking them to a random open access image!

## Local development

Ruby 3 and Rails 6. Install Docker (Compose), which makes it trivial to set up and run this project (web application and Postgres database) with `docker-compose up` after cloning. The web application will be on port 3000, the database on 5432.

When starting for the first time, in order to create the database, make sure to run `docker-compose run web rails db:migrate`.

In order to run the test suite, execute `docker-compose run web rails test`

## Environment variables

Although the default engine for ActiveStorage locally is just the local filesystem, if you wish to use AWS S3, then make sure the relevant variables are defined in a `.env` file in the root repository directory:

```
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_REGION=
AWS_BUCKET=
```

If deploying, make sure to fill out the `DATABASE_URL` variable as well.

## Feature ideation

- Searching by tags
- Alternate stream views e.g. grid
- Comments on posts
