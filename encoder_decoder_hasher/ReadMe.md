# DumpTR – Encode / Decode / Hash

DumpTR is a Bash-based CLI tool for converting, decoding, encoding, and hashing data across multiple formats.

---

## USAGE

```bash
./dumptr -i "<input>" -e <mode>
```
```bash
./dumptr -i "<input>" -d <mode>
```
```bash
./dumptr -i "<input>" -h <mode>
```
```bash
./dumptr -f <file> -e <mode>
```
```bash
./dumptr -f <file> -d <mode>
```
```bash
./dumptr -f <file> -h <mode>
```
---

## OPTIONS

##### -i   Direct input string

##### -f   Input from file

##### -e   Encode mode

##### -d   Decode mode

##### -h   Hash mode

---

## DECODE MODES

- bin - Binary -> ASCII

- hex - Hex -> ASCII

- b32 - Base32 -> ASCII

- b64 - Base64 -> ASCII

- b58 - Base58 -> ASCII

- all - Try all decode methods

## ENCODE MODES

- bin - ASCII -> Binary

- hex - ASCII -> Hex

- b32 - ASCII -> Base32

- b64 - ASCII -> Base64

- b58 - ASCII -> Base58

- all - Encode in all formats

## HASH MODES

- md5 - MD5 hash

- sha1 - SHA1 hash

- s224 - SHA224 hash

- s256 - SHA256 hash

- s384 - SHA384 hash

- s512 - SHA512 hash

- all - All hashes

---

## EXAMPLES
```bash
./dumptr -i "hello" -e b64
```
```bash
./dumptr -i "01101000 01100101" -d bin
```
```bash
./dumptr -i "hello" -h sha256
```