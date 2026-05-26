From QuickChick Require Import QuickChick.

Require Import TestingCommon.
Require Import Reachability.
Require Import SSNI.
Require Import SanityChecks.
Require Import ZArith.
Require Import BespokeGenerator.
From mathcomp Require Import ssreflect eqtype seq.
Import LabelEqType.


From PropLang Require Import PropLang.
Local Open Scope prop_scope.

Derive Instance Arbitrary for BinOpT.
Derive Instance Arbitrary for Instr.
Derive Instance Arbitrary for Pointer.
Derive Instance Arbitrary for Value.
Derive Instance Arbitrary for Atom.
Derive Instance Arbitrary for Ptr_atom.
Derive Instance Arbitrary for StackFrame.
Derive Instance Arbitrary for Stack.
Derive Instance Arbitrary for SState.
Derive Instance Arbitrary for Variation.

Definition propLLNI :=
  ForAll "v" (fun _ => arbitrary) (fun _ _ => arbitrary) (fun _ => shrink) (fun _ => show) (
  Implies ((@Variation SState) · ∅) (fun '((Var lab st1 st2), _) => indist lab st1 st2) (
  Implies ((@Variation SState) · ∅) (fun '((Var lab st1 st2), _) => well_formed st1) (
  Implies ((@Variation SState) · ∅) (fun '((Var lab st1 st2), _) => well_formed st2) (
  @ForAll (option (bool * nat)) ((@Variation SState) · ∅) "result" (fun '(v, _) => returnGen (low_indist 100 default_table v 0)) (fun '(v, _) _ => returnGen (low_indist 100 default_table v 0)) (fun _ => shrink) (fun _ => show) (
  Implies ((option (bool * nat)) · _) (fun '(result, _) => is_some result) (
  Check ((option (bool * nat)) · _) (fun '(result, _) => 
    fst (unwrap_or result (false, 0))
  ))))))).

Definition test_propLLNI := runLoop number_of_trials propLLNI.
(*! QuickProp test_propLLNI.  *)