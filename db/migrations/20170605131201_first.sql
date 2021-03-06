-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied

CREATE SEQUENCE public.users_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.users_id_seq
    OWNER TO testuser;

CREATE TABLE users(
  id INTEGER NOT NULL DEFAULT nextval('users_id_seq'::regclass),
  email VARCHAR NOT NULL UNIQUE,
  login VARCHAR NOT NULL UNIQUE,
  password VARCHAR NOT NULL,
  subscribed BOOLEAN NOT NULL DEFAULT FALSE,
  created_at timestamp without time zone,
  updated_at timestamp without time zone
);

INSERT INTO public.users(email, password, login) VALUES ('joiey.seeley@gmail.com', 'test', 'bigtunacan');

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE users;
DROP SEQUENCE IF EXISTS users_id_seq;
