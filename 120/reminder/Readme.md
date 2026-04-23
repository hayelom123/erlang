````md
# Standard Erlang Directory Structure

To begin, we should lay down a standard Erlang directory structure:

```text
ebin/
include/
priv/
src/
```
````

## Directory Purpose

These directories store files as follows:

- **ebin/**
  This directory is where files will go once they are compiled.

- **include/**
  This directory is used to store `.hrl` files that are to be included by other applications (private `.hrl` files are usually kept inside the `src/` directory).

- **priv/**
  This directory is used for executables that might need to interact with Erlang, such as specific drivers and related files. We won’t actually use this directory for this project.

- **src/**
  This directory is where all `.erl` files stay.

## Notes About Variations

In standard Erlang projects, this directory structure can vary a little.

Additional directories may include:

- **conf/** for specific configuration files
- **doc/** for documentation
- **lib/** or **deps/** for third-party libraries required for your application to run

Erlang products in the market often use different directory names, but the four main directories in our structure usually stay the same, since they are part of standard OTP practices.

```

```
