-- This module provides for dependently typed indexed lists. See
-- 'Idx' for more information.
module Snowdrift.Mechanism.Idx

-- For some indexed type, this provides a type for a list where, for
-- all natural numbers n, the n'th element of the list has type t n.
--
-- For instance, say you wanted to implement triangular matrices,
-- with m columns.  that could be expressed as Idx (\n -> Vect n t)
-- m. So, the m'th column would contain a vector of length m, for all
-- m.
--
-- In this application, these are used, when you have a bunch of
-- Patrons, each with a unique natural number id, to ensure that if
-- there are n entries in the list, that there is a Patron whose id
-- is m, for all m less than n.
data Idx : (Nat -> Type) -> Nat -> Type where
  IdxNil : Idx t Z
  IdxCons : t n -> Idx t n -> Idx t (S n)

-- This is a workaround for dealing with lists of elements with an
-- indexed type. Ordinary lists cannot contain elements of differing
-- types. This allows a list of elements whose type differs only by
-- their index.
using (t : Nat -> Type)
  data NoIdx : (Nat -> Type) -> Type where
    NoIdxNil : NoIdx t
    NoIdxCons : t n -> NoIdx t -> NoIdx t
