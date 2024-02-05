type anchor =
  {
    token : string;   (* anchor token *)
    prefix : string;  (* prefix generated for math splice *)
    suffix : string;  (* suffix generated for math splice *)
    newline : bool;   (* use newlines *)
    indent : string;  (* inserted after generated newlines *)
  }

type config =
  {
    (* Anchor token for splices *)
    anchors : anchor list;

    (* Latex *)
    latex : Backend_latex.Config.t;

    (* Prose *)
    prose : Backend_prose.Config.t;
  }

type t = config

let latex =
  { anchors = [
      {token = "#"; prefix = "$"; suffix = "$"; newline = false; indent = ""};
      {token = "##"; prefix = "$$\n"; suffix = "\n$$"; newline = true; indent = ""};
    ];
    latex = Backend_latex.Config.default;
    prose = Backend_prose.Config.default;
  }

let sphinx =
  { anchors = [
      {token = "$"; prefix = ":math:`"; suffix = "`"; newline = false; indent = ""};
      {token = "$$"; prefix = ".. math::\n   "; suffix = ""; newline = true; indent = "   "};
    ];
    latex = Backend_latex.Config.default;
    prose = Backend_prose.Config.default;
  }
