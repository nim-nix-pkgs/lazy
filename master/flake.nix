{
  description = ''Iterator library for Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-lazy-master.flake = false;
  inputs.src-lazy-master.owner = "petermora";
  inputs.src-lazy-master.ref   = "refs/heads/master";
  inputs.src-lazy-master.repo  = "nimLazy";
  inputs.src-lazy-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-lazy-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-lazy-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}