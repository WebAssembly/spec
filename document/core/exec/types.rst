.. index:: type, semantic type
.. _exec-type:

Types
-----

Execution has to check and compare :ref:`types <syntax-type>` and :ref:`type instances <syntax-typeinst>` in a few places, such as :ref:`executing <exec-call_indirect>` |CALLINDIRECT| or :ref:`instantiating <exec-instantiation>` :ref:`modules <syntax-module>`.
During execution, types of all forms are represented as :ref:`semantic <syntax-type-sem>` types, where all occurring :ref:`type identifiers <syntax-typeid>` are interpreted as :ref:`type addresses <syntax-typeaddr>`.
Relevant type relations need to be redefined accordingly.

.. note::
   Runtime type checks generally involve types from multiple modules or types not defined by a module at all, such that module-local :ref:`type indices <syntax-typeidx>` are not meaningful.
   Type addresses are global to a :ref:`store <syntax-store>` and can hence be interpreted independent of module boundaries.


.. index:: type identifier, type address, store
   pair: validation; type identifier
   single: abstract syntax; type identifier
.. _valid-typeaddr:

Type Identifiers
~~~~~~~~~~~~~~~~

During execution, :ref:`type identifiers <syntax-typeid>` are represented as :ref:`type addresses <syntax-typeaddr>`, which are looked up as :ref:`function types <syntax-functype>` in the :ref:`store <syntax-store>` by the following rule.

:math:`\typeaddr`
.................

* The type :math:`S.\STYPES[\typeaddr]` must be defined in the store.

* Then the type address is valid as :ref:`function type <syntax-functype>` :math:`S.\STYPES[\typeaddr]`.

.. math::
   \frac{
     S.\STYPES[\typeaddr] = \functype
   }{
     S \vdashtypeid \typeaddr : \functype
   }

.. note::
   Unlike :ref:`type indices <syntax-typeidx>` recorded in a context, the number of type addresses in a store is not bounded by :math:`2^{32}`.


.. index:: type identifier, type index, type address, type instantiation, module instance, semantic type

.. _sem:

Instantiation
~~~~~~~~~~~~~

Any form of :ref:`syntactic <syntax-type-syn>` :ref:`type <syntax-type>` can be *instantiated* into a :ref:`semantic <syntax-type-sem>` type inside a :ref:`module instance <syntax-moduleinst>` by :ref:`substituting <notation-subst>` each :ref:`type index <syntax-typeidx>` :math:`x` occurring in it with the corresponding :ref:`type address <syntax-typeaddr>` :math:`\moduleinst.\MITYPES[x]`.

.. math::
   \sem_{\moduleinst}(t) = t[\subst \moduleinst.\MITYPES]


.. index:: type, matching, store, semantic types, validity
.. _exec-match:
.. _exec-valid-type:

Matching and Validity
~~~~~~~~~~~~~~~~~~~~~

For each *static* :ref:`matching relation <match>` on syntactic types, operating relative to a :ref:`context <context>`, an analogous *dynamic* validity or matching relation is defined, operating relative to a :ref:`store <syntax-store>`.

Formally, for each judgement

.. math:: C \vdash T_1 \matches T_2

on syntactic types :math:`T_1` and :math:`T_2`, an analogous judgement

.. math:: S \vdash T'_1 \matches T'_2

on corresponding semantic types :math:`T'_1` and :math:`T'_2` is introduced. It is defined analogously, by replacing all occurrences of a :ref:`context <context>` :math:`C` in the associated rules with a :ref:`store <syntax-store>` :math:`S`.

.. note::
   Where the static rules invoke :ref:`static lookup <valid-typeidx>` for :ref:`type indices <syntax-typeidx>` in the context, the dynamic rules thereby invoke :ref:`dynamic lookup <valid-typeaddr>` for :ref:`type addresses <syntax-typeaddr>` in the store.

Likewise, for each *static* :ref:`validity rule <valid-type>` on syntactic types, operating relative to a :ref:`context <context>`, an analogous *dynamic* validity rule is defined, operating relative to a :ref:`store <syntax-store>`.

Formally, for each judgement

.. math:: C \vdash T \ok

on syntactic type :math:`T`, an analogous judgement

.. math:: S \vdash T' \ok

on corresponding semantic types :math:`T'` is introduced. It is defined analogously, by replacing all occurrences of a :ref:`context <context>` :math:`C` in the associated rules with a :ref:`store <syntax-store>` :math:`S`.

.. note::
   Dynamic validity rules are not needed for the semantics,
   but to prove :ref:`soundness <soundness-statement>`
   and for specifying parts of the :ref:`embedder <embed>` interface.
