.. index:: type, dynamic type
.. _exec-type:

Types
-----

Execution has to check and compare :ref:`types <syntax-type>` and :ref:`type instances <syntax-typeinst>` in a few places, such as :ref:`executing <exec-call_indirect>` |CALLINDIRECT| or :ref:`instantiating <exec-instantiation>` :ref:`modules <syntax-module>`.
During execution, types of all forms are represented as :ref:`dynamic <syntax-type-dyn>` types, where all occurring :ref:`type identifiers <syntax-typeid>` are interpreted as :ref:`type addresses <syntax-typeaddr>`.
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
     S; C \vdashtypeid \typeaddr : \functype
   }

.. note::
   Unlike :ref:`type indices <syntax-typeidx>` recorded in a context, the number of type addresses in a store is not bounded by :math:`2^{32}`.


.. index:: type identifier, type index, type address, type instantiation, module instance, dynamic type

.. _dyn:

Instantiation
~~~~~~~~~~~~~

Any form of :ref:`static <syntax-type-stat>` :ref:`type <syntax-type>` can be *instantiated* into a :ref:`dynamic <syntax-type-dyn>` type inside a :ref:`module instance <syntax-moduleinst>` by :ref:`substituting <notation-subst>` each :ref:`type index <syntax-typeidx>` :math:`x` occurring in it with the corresponding :ref:`type address <syntax-typeaddr>` :math:`\moduleinst.\MITYPES[x]`.

.. math::
   \dyn_{\moduleinst}(t) = t[\subst \moduleinst.\MITYPES]


.. index:: type, matching, store, dynamic types, validity
.. _exec-valid-type:
.. _exec-match:

Dynamic Typing
~~~~~~~~~~~~~~

To handle :ref:`dynamic <syntax-type-dyn>` types, all static judgements :math:`C \vdash \X{prop}` on types (such as :ref:`validity <valid-type>` and :ref:`matching <match>`) are generalized to include the store, as in :math:`S; C \vdash \X{prop}`, by implicitly adding a :ref:`store <syntax-store>` :math:`S` to all rules -- :math:`S` is never modified by the pre-existing rules, but it is accessed in the extra rule for :ref:`type addresses <syntax-typeaddr>` given :ref:`above <valid-typeaddr>`.

It is an invariant of the semantics that all types inspected by execution rules are dynamic, i.e., the :ref:`context <context>` is always empty and never used.
To avoid unnecessary clutter, empty contexts are omitted from the rules, writing just :math:`S \vdash \X{prop}`.

.. note::
   Only matching rules are invoked during execution.
   Dynamic validity is only needed to prove :ref:`type soundness <soundness>`
   and for specifying parts of the :ref:`embedder <embed>` interface.
