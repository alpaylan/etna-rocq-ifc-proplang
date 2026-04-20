# etna-rocq-ifc-proplang

IFCProplang workload for [Etna](https://github.com/alpaylan/etna-cli) (Rocq/Coq).

Uses the [PropLang](https://github.com/alpaylan/etna-rocq-lib) runner
framework, vendored here as a git submodule at `./Lib/`. The
`setup_steps` in `steps.json` runs `./Lib/build -i` first so
`coqc` can resolve `From PropLang Require Import PropLang.` in the
workload's runners.

## Usage

```
etna experiment create my-exp
etna workload add https://github.com/alpaylan/etna-rocq-ifc-proplang
```
