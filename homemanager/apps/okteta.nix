{pkgs, ...}: {
  home.packages = [pkgs.okteta];
  xdg.mimeApps.defaultApplications = import ../util/fill-with.nix {
    value = ["okteta.desktop"];
    keys = [
      # "application/acad" # .dwg
      # "application/arj" # .arj
      # "application/base64" = text; # .mm .mme
      "application/binhex4" # .hqx
      "application/binhex" # .hqx
      # "application/book" # .boo .book
      # "application/cdf" # .cdf
      # "application/clariscad" # .ccad
      # "application/commonground" # .dp
      # "application/drafting" # .drw
      # "application/dsptype" # .tsp
      # "application/dxf" # .dxf
      # "application/envoy" # .evy
      # "application/fractals" # .fif
      # "application/freeloader" # .frl
      # "application/futuresplash" # .spl
      # "application/gnutar" = archive; # .tgz
      # "application/groupwise" # .vew
      # "application/hlp" # .hlp
      # "application/hta" # .hta
      # "application/i-deas" # .unv
      # "application/iges" # .iges .igs
      # "application/inf" # .inf
      # "application/lha" # .lha
      # "application/lzx" # .lzx
      # "application/mac-binary" # .bin
      # "application/macbinary" # .bin
      # "application/mac-binhex40" # .hqx
      # "application/mac-binhex" # .hqx
      # "application/mac-compactpro" # .cpt
      # "application/marc" # .mrc
      # "application/mbedlet" # .mbd
      # "application/mcad" # .mcd
      # "application/mime" # .aps
      # "application/mswrite" # .wri
      # "application/netmc" # .mcp
      # "application/octet-stream" # .a .arc .arj .bin .com .dump .exe .lha .lhx .lzh .lzx .o .psd .saveme .uu .zoo
      # "application/oda" # .oda
      # "application/pkcs10" # .p10
      # "application/pkcs-12" # .p12
      # "application/pkcs7-mime" # .p7c .p7m
      # "application/pkcs7-signature" # .p7s
      # "application/pkcs-crl" # .crl
      # "application/pkix-cert" # .cer .crt
      # "application/pkix-crl" # .crl
      # "application/plain" # .text
      # "application/postscript" # .ai .eps .ps
      # "application/pro_eng" # .part .prt
      # "application/ringing-tones" # .rng
      # "application/rtf" # .rtf .rtx
      # "application/sdp" # .sdp
      # "application/sea" # .sea
      # "application/set" # .set
      # "application/sla" # .stl
      # "application/smil" # .smi .smil
      # "application/solids" # .sol
      # "application/sounder" # .sdr
      # "application/step" # .step .stp
      # "application/streamingmedia" # .ssm
      # "application/toolbook" # .tbk
      # "application/vda" # .vda
      # "application/vnd.fdf" # .fdf
      # "application/vnd.hp-hpgl" # .hgl .hpg .hpgl
      # "application/vnd.hp-pcl" # .pcl
      # "application/vnd.ms-excel" # .xlb .xlc .xll .xlm .xls .xlw
      # "application/vnd.ms-pki.certstore" # .sst
      # "application/vnd.ms-pki.pko" # .pko
      # "application/vnd.ms-pki.seccat" # .cat
      # "application/vnd.ms-pki.stl" # .stl
      # "application/vnd.ms-powerpoint" # .pot .ppa .pps .ppt .pwz
      # "application/vnd.ms-project" # .mpp
      # "application/vnd.nokia.configuration-message" # .ncm
      # "application/vnd.nokia.ringing-tone" # .rng
      # "application/vnd.rn-realmedia" # .rm
      # "application/vnd.rn-realplayer" # .rnx
      # "application/vnd.wap.wmlc" # .wmlc
      # "application/vnd.wap.wmlscriptc" # .wmlsc
      # "application/vnd.xara" # .web
      # "application/vocaltec-media-desc" # .vmd
      # "application/vocaltec-media-file" # .vmf
      # "application/wordperfect6.0" # .w60 .wp5
      # "application/wordperfect6.1" # .w61
      # "application/wordperfect" # .wp .wp5 .wp6 .wpd
      # "application/x-123" # .wk1
      # "application/x-aim" # .aim
      # "application/x-authorware-bin" # .aab
      # "application/x-authorware-map" # .aam
      # "application/x-authorware-seg" # .aas
      # "application/x-bcpio" # .bcpio
      # "application/x-binary" # .bin
      # "application/x-binhex40" # .hqx
      # "application/x-bsh" # .bsh .sh .shar
      # "application/x-bytecode.elisp" # .elc(compiled_elisp)
      # "application/x-bytecode.python" # .pyc
      # "application/x-bzip2" # .boz .bz2
      # "application/x-bzip" # .bz
      # "application/x-cdf" # .cdf
      # "application/x-cdlink" # .vcd
      # "application/x-chat" # .cha .chat
      # "application/x-cmu-raster" # .ras
      # "application/x-cocoa" # .cco
      # "application/x-compactpro" # .cpt
      # "application/x-compressed" # .gz .tgz .z .zip
      # "application/x-compress" # .z
      # "application/x-conference" # .nsc
      # "application/x-cpio" # .cpio
      # "application/x-cpt" # .cpt
      # "application/x-csh" # .csh
      # "application/x-deepv" # .deepv
      # "application/x-director" # .dcr .dir .dxr
      # "application/x-dvi" # .dvi
      # "application/x-elc" # .elc
      # "application/x-envoy" # .env .evy
      # "application/x-esrehber" # .es
      # "application/x-excel" # .xla .xlb .xlc .xld .xlk .xll .xlm .xls .xlt .xlv .xlw
      # "application/x-frame" # .mif
      # "application/x-freelance" # .pre
      # "application/x-gsp" # .gsp
      # "application/x-gss" # .gss
      # "application/x-gtar" # .gtar
      # "application/x-gzip" # .gz .gzip
      # "application/x-hdf" # .hdf
      # "application/x-helpfile" # .help .hlp
      # "application/x-httpd-imap" # .imap
      # "application/x-ima" # .ima
      # "application/x-internett-signup" # .ins
      # "application/x-inventor" # .iv
      # "application/x-ip2" # .ip
      # "application/x-java-class" # .class
      # "application/x-java-commerce" # .jcm
      # "application/x-javascript" # .js
      # "application/x-koan" # .skd .skm .skp .skt
      # "application/x-ksh" # .ksh
      # "application/x-latex" # .latex .ltx
      # "application/x-lha" # .lha
      # "application/x-lisp" # .lsp
      # "application/x-livescreen" # .ivy
      # "application/x-lotusscreencam" # .scm
      # "application/x-lotus" # .wq1
      # "application/x-lzh" # .lzh
      # "application/x-lzx" # .lzx
      # "application/x-macbinary" # .bin
      # "application/x-mac-binhex40" # .hqx
      # "application/x-magic-cap-package-1.0" # .mc$
      # "application/x-mathcad" # .mcd
      # "application/x-meme" # .mm
      # "application/x-midi" # .mid .midi
      # "application/x-mif" # .mif
      # "application/x-mix-transfer" # .nix
      # "application/xml" # .xml
      # "application/x-mplayer2" # .asx
      # "application/x-msexcel" # .xla .xls .xlw
      # "application/x-mspowerpoint" # .ppt
      # "application/x-navi-animation" # .ani
      # "application/x-navidoc" # .nvd
      # "application/x-navimap" # .map
      # "application/x-navistyle" # .stl
      # "application/x-netcdf" # .cdf .nc
      # "application/x-newton-compatible-pkg" # .pkg
      # "application/x-nokia-9000-communicator-add-on-software" # .aos
      # "application/x-omcdatamaker" # .omcd
      # "application/x-omc" # .omc
      # "application/x-omcregerator" # .omcr
      # "application/x-pagemaker" # .pm4 .pm5
      # "application/x-pcl" # .pcl
      # "application/x-pixclscript" # .plx
      # "application/x-pkcs10" # .p10
      # "application/x-pkcs12" # .p12
      # "application/x-pkcs7-certificates" # .spc
      # "application/x-pkcs7-certreqresp" # .p7r
      # "application/x-pkcs7-mime" # .p7c .p7m
      # "application/x-pkcs7-signature" # .p7a
      # "application/x-pointplus" # .css
      # "application/x-portable-anymap" # .pnm
      # "application/x-project" # .mpc .mpt .mpv .mpx
      # "application/x-qpro" # .wb1
      # "application/x-rtf" # .rtf
      # "application/x-sdp" # .sdp
      # "application/x-sea" # .sea
      # "application/x-seelogo" # .sl
      # "application/x-shar" # .sh .shar
      # "application/x-shockwave-flash" # .swf
      # "application/x-sh" # .sh
      # "application/x-sit" # .sit
      # "application/x-sprite" # .spr .sprite
      # "application/x-stuffit" # .sit
      # "application/x-sv4cpio" # .sv4cpio
      # "application/x-sv4crc" # .sv4crc
      # "application/x-tar" # .tar
      # "application/x-tbook" # .sbk .tbk
      # "application/x-tcl" # .tcl
      # "application/x-texinfo" # .texi .texinfo
      # "application/x-tex" # .tex
      # "application/x-troff-man" # .man
      # "application/x-troff-me" # .me
      # "application/x-troff-ms" # .ms
      # "application/x-troff-msvideo" # .avi
      # "application/x-troff" # .roff .t .tr
      # "application/x-ustar" # .ustar
      # "application/x-visio" # .vsd .vst .vsw
      # "application/x-vnd.audioexplosion.mzz" # .mzz
      # "application/x-vnd.ls-xpix" # .xpix
      # "application/x-vrml" # .vrml
      # "application/x-wais-source" # .src .wsrc
      # "application/x-winhelp" # .hlp
      # "application/x-wintalk" # .wtk
      # "application/x-world" # .svr .wrl
      # "application/x-wpwin" # .wpd
      # "application/x-wri" # .wri
      # "application/x-x509-ca-cert" # .cer .crt .der
      # "application/x-x509-user-cert" # .crt
      # "application/x-zip-compressed" = archive; # .zip
      # "application/zip" = archive; # .zip
      # "audio/aiff" = music; # .aif .aifc .aiff
      # "audio/basic" = music; # .au .snd
      # "audio/it" = music; # .it
      # "audio/make" = music; # .funk .my .pfunk
      # "audio/make.my.funk" = music; # .pfunk
      # "audio/midi" = music; # .kar .mid .midi
      # "audio/mid" = music; # .rmi
      # "audio/mod" = music; # .mod
      # "audio/mpeg3" = music; # .mp3
      # "audio/mpeg" = music; # .m2a .mp2 .mpa .mpg .mpga
      # "audio/nspaudio" = music; # .la .lma
      # "audio/s3m" = music; # .s3m
      # "audio/tsp-audio" = music; # .tsi
      # "audio/tsplayer" = music; # .tsp
      # "audio/vnd.qcelp" = music; # .qcp
      # "audio/voc" = music; # .voc
      # "audio/voxware" = music; # .vox
      # "audio/wav" = music; # .wav
      # "audio/x-adpcm" = music; # .snd
      # "audio/x-aiff" = music; # .aif .aifc .aiff
      # "audio/x-au" = music; # .au
      # "audio/x-gsm" = music; # .gsd .gsm
      # "audio/x-jam" = music; # .jam
      # "audio/x-liveaudio" = music; # .lam
      # "audio/x-midi" = music; # .mid .midi
      # "audio/x-mid" = music; # .mid .midi
      # "audio/x-mod" = music; # .mod
      # "audio/x-mpeg-3" = music; # .mp3
      # "audio/x-mpeg" = music; # .mp2
      # "audio/x-mpequrl" = music; # .m3u
      # "audio/xm" = music; # .xm
      # "audio/x-nspaudio" = music; # .la .lma
      # "audio/x-pn-realaudio-plugin" = music; # .ra .rmp .rpm
      # "audio/x-pn-realaudio" = music; # .ra .ram .rm .rmm .rmp
      # "audio/x-psid" = music; # .sid
      # "audio/x-realaudio" = music; # .ra
      # "audio/x-twinvq-plugin" = music; # .vqe .vql
      # "audio/x-twinvq" = music; # .vqf
      # "audio/x-vnd.audioexplosion.mjuicemediafile" = music; # .mjf
      # "audio/x-voc" = music; # .voc
      # "audio/x-wav" = music; # .wav
      # "chemical/x-pdb" # .pdb .xyz
      # "drawing/x-dwf" # .dwf (old)
      # "i-world/i-vrml" # .ivr
      # "message/rfc822" # .mht .mhtml .mime
      # "model/iges" # .iges .igs
      # "model/vnd.dwf" # .dwf
      # "model/vrml" # .vrml .wrl .wrz
      # "model/x-pov" # .pov
      # "multipart/x-gzip" = archive; # .gzip
      # "multipart/x-ustar" = archive; # .ustar
      # "multipart/x-zip" = archive; # .zip
      # "music/crescendo" = music; # .mid .midi
      # "music/x-karaoke" = music; # .kar
      # "paleovu/x-pv" # .pvu
      # "text/asp" = text; # .asp
      # "text/ecmascript" = text; # .js
      # "text/mcf" = text; # .mcf
      # "text/scriplet" = text; # .wsc
      # "text/sgml" = text; # .sgm .sgml
      # "text/uri-list" = text; # .uni .unis .uri .uris
      # "text/vnd.abc" = text; # .abc
      # "text/vnd.fmi.flexstor" = text; # .flx
      # "text/vnd.rn-realtext" = text; # .rt
      # "text/vnd.wap.wmlscript" = text; # .wmls
      # "text/vnd.wap.wml" = text; # .wml
      # "text/webviewhtml" = text; # .htt
      # "text/x-audiosoft-intra" = text; # .aip
      # "text/x-component" = text; # .htc
      # "text/x-fortran" = text; # .f .f77 .f90 .for
      # "text/x-la-asf" = text; # .lsx
      # "text/xml" = browser; # .xml
      # "text/x-m" = text; # .m
      # "text/x-pascal" = text; # .p
      # "text/x-script.csh" = text; # .csh
      # "text/x-script.elisp" = text; # .el
      # "text/x-script.guile" = text; # .scm
      # "text/x-script" = text; # .hlb
      # "text/x-script.ksh" = text; # .ksh
      # "text/x-script.lisp" = text; # .lsp
      # "text/x-script.perl-module" = text; # .pm
      # "text/x-script.perl" = text; # .pl
      # "text/x-script.phyton" = text; # .py
      # "text/x-script.rexx" = text; # .rexx
      # "text/x-script.scheme" = text; # .scm
      # "text/x-script.sh" = text; # .sh
      # "text/x-script.tcl" = text; # .tcl
      # "text/x-script.tcsh" = text; # .tcsh
      # "text/x-script.zsh" = text; # .zsh
      # "text/x-server-parsed-html" = text; # .shtml .ssi
      # "text/x-setext" = text; # .etx
      # "text/x-sgml" = text; # .sgm .sgml
      # "text/x-speech" = text; # .spc .talk
      # "text/x-uil" = text; # .uil
      # "text/x-uuencode" = text; # .uu .uue
      # "text/x-vcalendar" = text; # .vcs
      # "video/animaflex" = video; # .afl
      # "video/avi" = video; # .avi
      # "video/avs-video" = video; # .avs
      # "video/dl" = video; # .dl
      # "video/fli" = video; # .fli
      # "video/gl" = video; # .gl
      # "video/mpeg" = video; # .m1v .m2v .mp2 .mp3 .mpa .mpe .mpeg .mpg
      # "video/msvideo" = video; # .avi
      # "video/quicktime" = video; # .moov .mov .qt
      # "video/vdo" = video; # .vdo
      # "video/vivo" = video; # .viv .vivo
      # "video/vnd.rn-realvideo" = video; # .rv
      # "video/vnd.vivo" = video; # .viv .vivo
      # "video/vosaic" = video; # .vos
      # "video/x-amt-demorun" = video; # .xdr
      # "video/x-amt-showrun" = video; # .xsr
      # "video/x-atomic3d-feature" = video; # .fmf
      # "video/x-dl" = video; # .dl
      # "video/x-dv" = video; # .dif .dv
      # "video/x-fli" = video; # .fli
      # "video/x-gl" = video; # .gl
      # "video/x-isvideo" = video; # .isu
      # "video/x-motion-jpeg" = video; # .mjpg
      # "video/x-mpeg" = video; # .mp2 .mp3
      # "video/x-mpeq2a" = video; # .mp2
      # "video/x-ms-asf" = video; # .asf .asx
      # "video/x-ms-asf-plugin" = video; # .asx
      # "video/x-msvideo" = video; # .avi
      # "video/x-qtc" = video; # .qtc
      # "video/x-scm" = video; # .scm
      # "video/x-sgi-movie" = video; # .movie .mv
      # "windows/metafile" = video; # .wmf
      # "www/mime" = browser; # .mime
      # "x-conference/x-cooltalk" # .ice
      # "xgl/drawing" # .xgz
      # "xgl/movie" # .xmz
      # "x-music/x-midi" = music; # .mid .midi
      # "x-world/x-3dmf" # .3dm .3dmf .qd3 .qd3d
      # "x-world/x-svr" # .svr
      # "x-world/x-vrml" # .vrml .wrl .wrz
      # "x-world/x-vrt" # .vrt
    ];
  };
}
