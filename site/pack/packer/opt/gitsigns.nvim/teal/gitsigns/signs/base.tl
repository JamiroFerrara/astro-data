local SignsConfig = require('gitsigns.config').Config.SignsConfig

local record M
  enum SignType
    "add"
    "delete"
    "change"
    "topdelete"
    "changedelete"
    "untracked"
  end

  record Sign
    type: SignType
    count: integer
    lnum: integer
  end

  record HlDef
    hl: string
    numhl: string
    linehl: string
  end

  hls: {SignType:HlDef}

  name: string
  group: string
  config: SignsConfig

  -- Used by signs/extmarks.tl
  ns: integer

  -- Used by signs/vimfn.tl
  placed: {integer:{integer:Sign}}

  new      : function(cfg: SignsConfig, name: string): M
  _new     : function(cfg: SignsConfig, hls: {SignType:HlDef}, name: string): M
  remove   : function(M, bufnr: integer, start_lnum: integer, end_lnum: integer)
  add      : function(M, bufnr: integer, signs: {M.Sign})
  contains : function(M, bufnr: integer, start: integer, last: integer): boolean
  on_lines : function(M, bufnr: integer, first: integer, last_orig: integer, last_new: integer)
  reset    : function(M)
end

return M
