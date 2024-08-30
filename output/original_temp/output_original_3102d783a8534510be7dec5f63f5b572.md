To use a package from `nixpkgs` unstable with `nix-shell`, you can follow these steps:

1. **Specify the `nixpkgs` channel**:
   - By default, `nixpkgs` uses the stable channel. To use the unstable channel, you need to specify it.

2. **Use `nix-shell` with the `-p` flag**:
   - The `-p` flag is used to specify the package(s) you want to install.

Here's a step-by-step guide:

### Using `nix-shell` with Unstable `nixpkgs`

1. **Specify the `nixpkgs` channel**:

   - To use the unstable channel, you can use the following command:

     ```bash
     nix-shell -p <package> --argstr nixpkgsRepo nixpkgs-unstable
     ```

   - Replace `<package>` with the name of the package you want to use.

2. **Using `nix-shell` with Multiple Packages**:

   - If you need to use multiple packages, you can specify them separated by commas:

     ```bash
     nix-shell -p <package1>,<package2> --argstr nixpkgsRepo nixpkgs-unstable
     ```

   - Replace `<package1>` and `<package2>` with the names of the packages you want to use.

### Example

- To use `git` from the unstable `nixpkgs` channel:

  ```bash
  nix-shell -p git --argstr nixpkgsRepo nixpkgs-unstable
  ```

- To use both `git` and `python` from the unstable `nixpkgs` channel:

  ```bash
  nix-shell -p git,python --argstr nixpkgsRepo nixpkgs-unstable
  ```

After running `nix-shell`, you'll be inside a shell environment where the specified packages are available.