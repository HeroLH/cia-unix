# cia-unix

*Decrypt CIA roms in UNIX environments* 🪐

> **Note**
> A new Python 3 (unstable) version has been released, you can find the experimental code [here](https://github.com/shijimasoft/cia-unix/tree/experimental).  
> forked by [this repo](https://github.com/shijimasoft/cia-unix), click [here](https://github.com/shijimasoft/cia-unix/blob/main/README.md) to read the original README.


### Adjustment
- Add `decrypt_for_citra.sh` file to support decryption of cia for use by citra.
- Add support for Dockerfile files, so that people without python2 environment can run them.


### Instructions for use
#### run by shell
> Provided that you have read the [original documentation](https://github.com/shijimasoft/cia-unix/blob/main/README.md) and installed the dependencies
- Step 1: Create a `cia` folder and a `cia-decrypt` folder.
- Step 2: Place your .cia file in the `cia` folder.
- Step 3: Execute the following code:
  ```shell
  ./decrypt_for_citra.sh
  ```
- Step 4: The generated decryption file is in folder `cia-decrypt`.

#### run by docker
```shell
docker run -it -d -v /home/docker/cia-decrypt/cia:/usr/local/cia -v /home/docker/cia-decrypt/cia-decrypt:/usr/local/cia-decrypt --name cia-decrypt herolhh/cia-decrypt:0.0.1 
docker exec cia-decrypt ./decrypt_for_citra.sh 
```