.. index:: type, dynamic type
.. _exec-type:

Types
-----

Execution has to check and compare :ref:`types <syntax-type>` in a few places, such as :ref:`executing <exec-call_indirect>` ${:CALL_INDIRECT} or :ref:`instantiating <exec-instantiation>` :ref:`modules <syntax-module>`.

It is an invariant of the semantics that all types occurring during execution are :ref:`closed <type-closed>`.

.. note::
   Runtime type checks generally involve types from multiple modules or types not defined by a module at all, such that module-local :ref:`type indices <syntax-typeidx>` are not meaningful.



.. index:: type index, defined type, type instantiation, module instance, dynamic type

.. _type-inst:

Instantiation
~~~~~~~~~~~~~

Any form of :ref:`type <syntax-type>` can be *instantiated* into a :ref:`closed <type-closed>` type inside a :ref:`module instance <syntax-moduleinst>` by :ref:`substituting <notation-subst>` each :ref:`type index <syntax-typeidx>` ${:x} occurring in it with the corresponding :ref:`defined type <syntax-deftype>` ${deftype: moduleinst.TYPES[x]}.

$${definition: inst_valtype}
$${definition-ignore: inst_reftype}

.. math::
   \insttype_{\moduleinst}(t) = t[\subst \moduleinst.\MITYPES]

.. note::
   This is the runtime equivalent to :ref:`type closure <type-closure>`.
