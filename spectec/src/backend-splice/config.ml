type anchor =
  {
    token : string;   (* anchor token *)
    prefix : string;  (* prefix generated for math splice *)
    suffix : string;  (* suffix generated for math splice *)
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
      {token = "#"; prefix = "$"; suffix = "$"; indent = ""};
      {token = "##"; prefix = "$$\n"; suffix = "\n$$"; indent = ""};
    ];
    latex = Backend_latex.Config.default;
    prose = Backend_prose.Config.default;
  }

let sphinx =
  { anchors = [
      {token = "$"; prefix = ":math:`"; suffix = "`"; indent = ""};
      {token = "$$"; prefix = ".. math::\n   "; suffix = ""; indent = "   "};
    ];
    latex = Backend_latex.Config.default;
    prose = Backend_prose.Config.default;
  }
