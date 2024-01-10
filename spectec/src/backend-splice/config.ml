type anchor =
  {
    token : string;   (* anchor token *)
    prefix : string;  (* prefix generated for splice *)
    suffix : string;  (* suffix generated for splice *)
    indent : string;  (* inserted after generated newlines *)
  }

type config =
  {
    (* Anchor token for splices *)
    anchors : anchor list;

    (* Latex *)
    latex : Backend_latex.Config.config;

    (* Prose *)
    prose : Backend_prose.Config.config;
  }

let default =
  { anchors = [ {token = "%"; prefix = ""; suffix = ""; indent = ""} ];
    latex = Backend_latex.Config.default;
    prose = Backend_prose.Config.default;
  }

let latex =
  { anchors = default.anchors @ [
      {token = "@@"; prefix = "$"; suffix ="$"; indent = ""};
      {token = "@@@"; prefix = "$$\n"; suffix = "\n$$"; indent = ""};
    ];
    latex = Backend_latex.Config.latex;
    prose = Backend_prose.Config.latex;
  }

let sphinx =
  { anchors = default.anchors @ [
      {token = "$"; prefix = ":math:`"; suffix ="`"; indent = ""};
      {token = "$$"; prefix = ".. math::\n   "; suffix = ""; indent = "   "};
    ];
    latex = Backend_latex.Config.sphinx;
    prose = Backend_prose.Config.sphinx;
  }
