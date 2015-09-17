module FloatPrims : functor (Rep : Floatsig.REP) -> Floatsig.FLOAT with type bits = Rep.t
