open Values

module ExportMap = Map.Make(String)

type global = value ref

type func =
  | AstFunc of instance ref * Kernel.func
  | HostFunc of (value list -> value option)

and extern =
  | ExternalFunc of func
  | ExternalTable of Table.t
  | ExternalMemory of Memory.t
  | ExternalGlobal of value

and instance =
{
  module_ : Kernel.module_;
  funcs : func list;
  tables : Table.t list;
  memories : Memory.t list;
  globals : global list;
  exports : extern ExportMap.t;
}

exception Func of func

let instance m =
  { module_ = m; funcs = []; tables = []; memories = []; globals = [];
    exports = ExportMap.empty }

let export inst name =
  try Some (ExportMap.find name inst.exports) with Not_found -> None
