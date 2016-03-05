module Snowdrift.Mechanism.Types

import Snowdrift.Mechanism.Idx

data Pledge : Nat -> Nat -> Type where
  MkPledge : (pledgePatron : Nat)
          -> (pledgeProject : Nat)
          -> (pledgeAmount : Nat)
          -> Pledge pledgePatron pledgeProject
    
-- A patron has a name, an id number, and a discrete number of funds
-- left. (In practice, represented in 'mills', which is some fraction
-- of a US cent). The idea here is to prevent floating-point
-- arithmetic, which is error prone.
data Patron : Nat -> Type where
  MkPatron : (patronIdent : Nat)
           -> (patronHandle : String)
           -> (patronFunds : Nat)
           -> (patronPledges : {numberPledges : Nat} 
                             -> Idx (Pledge patronIdent) 
                                    numberPledges)
           -> Patron patronIdent
    

-- Each project has an ident and a name
data Project : Nat -> Type where
  MkProject : (projectIdent : Nat)
            -> (projectHandle : String)
            -> (projectPledges : {numberPledges : Nat} 
                               -> Idx (\patronId => Pledge patronId projectIdent)
                                      numberPledges)
            -> Project projectident
    
  
