#!/bin/sh

SCRIPT=$(readlink -f $0)
BASE_DIR=$(dirname $SCRIPT)

die()
{
   echo $1
   #exit 1
}

build_libretro_bsnes()
{
   if [ -z "$CC" ]; then
      CC=gcc
   fi

   cd $BASE_DIR
   if [ -d "libretro-bsnes/perf" ]; then
      echo "=== Building bSNES performance ==="
      cd libretro-bsnes/perf/higan
      make compiler="$CC" ui=target-libretro profile=performance -j4 || die "Failed to build bSNES performance core"
      cp -f out/libretro.so ../../libretro-bsnes-performance.so
   else
      echo "bSNES performance not fetched, skipping ..."
   fi

   cd $BASE_DIR
   if [ -d "libretro-bsnes/balanced" ]; then
      echo "=== Building bSNES balanced ==="
      cd libretro-bsnes/balanced/higan
      make compiler="$CC" ui=target-libretro profile=balanced -j4 || die "Failed to build bSNES balanced core"
      cp -f out/libretro.so ../../libretro-bsnes-balanced.so
   else
      echo "bSNES compat not fetched, skipping ..."
   fi

   cd $BASE_DIR
   if [ -d "libretro-bsnes" ]; then
      echo "=== Building bSNES accuracy ==="
      cd libretro-bsnes/higan
      make compiler="$CC" ui=target-libretro profile=accuracy -j4 || die "Failed to build bSNES accuracy core"
      cp -f out/libretro.so ../libretro-bsnes-accuracy.so
   fi
}

build_libretro_mednafen()
{
   cd $BASE_DIR
   if [ -d "libretro-mednafen" ]; then
      echo "=== Building Mednafen ==="
      cd libretro-mednafen

      for core in psx pce-fast wswan ngp gba snes vb
      do
         if [ -d $core ]; then
            cd $core
            make core=${core} -j4 || die "Failed to build mednafen/${core}"
            cp mednafen_$(echo ${core} | tr '[\-]' '[_]')_libretro.so ../libretro-mednafen-${core}.so
            cd ..
         fi
      done
   else
      echo "Mednafen not fetched, skipping ..."
   fi
}

build_libretro_s9x()
{
   cd $BASE_DIR
   if [ -d "libretro-s9x" ]; then
      echo "=== Building SNES9x ==="
      cd libretro-s9x/libretro
      make -j4 || die "Failed to build SNES9x"
      cp libretro.so ../libretro-snes9x.so
   else
      echo "SNES9x not fetched, skipping ..."
   fi
}

build_libretro_s9x_next()
{
   cd $BASE_DIR
   if [ -d "libretro-s9x-next" ]; then
      echo "=== Building SNES9x-Next ==="
      cd libretro-s9x-next/
      make -f Makefile.libretro -j4 || die "Failed to build SNES9x-Next"
      cp snes9x_next_libretro.so libretro-snes9x-next.so
   else
      echo "SNES9x-Next not fetched, skipping ..."
   fi
}

build_libretro_genplus()
{
   cd $BASE_DIR
   if [ -d "libretro-genplus" ]; then
      echo "=== Building Genplus GX ==="
      cd libretro-genplus/
      make -f Makefile.libretro -j4 || die "Failed to build Genplus GX"
      cp genesis_plus_gx_libretro.so libretro-genplus.so
   else
      echo "Genplus GX not fetched, skipping ..."
   fi
}

build_libretro_fba()
{
   cd $BASE_DIR
   if [ -d "libretro-fba" ]; then
      echo "=== Building Final Burn Alpha ==="
      cd libretro-fba/
      ./compile_libretro.sh make || die "Failed to build Final Burn Alpha"
      cp svn-current/trunk/fb_alpha_libretro.so libretro-fba.so
   else
      echo "Final Burn Alpha not fetched, skipping ..."
   fi
}

build_libretro_vba()
{
   cd $BASE_DIR
   if [ -d "libretro-vba" ]; then
      echo "=== Building VBA-Next ==="
      cd libretro-vba/
      make -f Makefile.libretro -j4 || die "Failed to build VBA-Next"
      cp vba_next_libretro.so libretro-vba.so
   else
      echo "VBA-Next not fetched, skipping ..."
   fi
}

build_libretro_bnes()
{
   cd $BASE_DIR
   if [ -d "libretro-bnes" ]; then
      echo "=== Building bNES ==="
      cd libretro-bnes
      mkdir -p obj
      make -j4 || die "Failed to build bNES"
      cp libretro.so libretro-bnes.so
   else
      echo "bNES not fetched, skipping ..."
   fi
}

build_libretro_fceu()
{
   cd $BASE_DIR
   if [ -d "libretro-fceu" ]; then
      echo "=== Building FCEU ==="
      cd libretro-fceu
      make -C fceumm-code -f Makefile.libretro -j4 || die "Failed to build FCEU"
      cp fceumm-code/fceumm_libretro.so libretro-fceu.so
   else
      echo "FCEU not fetched, skipping ..."
   fi
}

build_libretro_gambatte()
{
   cd $BASE_DIR
   if [ -d "libretro-gambatte" ]; then
      echo "=== Building Gambatte ==="
      cd libretro-gambatte/libgambatte
      make -f Makefile.libretro -j4 || die "Failed to build Gambatte"
      cp gambatte_libretro.so ../libretro-gambatte.so
   else
      echo "Gambatte not fetched, skipping ..."
   fi
}

build_libretro_meteor()
{
   cd $BASE_DIR
   if [ -d "libretro-meteor" ]; then
      echo "=== Building Meteor ==="
      cd libretro-meteor/libretro
      make -j4 || die "Failed to build Meteor"
      cp libretro.so ../libretro-meteor.so
   else
      echo "Meteor not fetched, skipping ..."
   fi
}

build_libretro_nx()
{
   cd $BASE_DIR
   if [ -d "libretro-nx" ]; then
      echo "=== Building NXEngine ==="
      cd libretro-nx
      make -j4 || die "Failed to build NXEngine"
      cp nxengine_libretro.so libretro-nx.so
   else
      echo "NXEngine not fetched, skipping ..."
   fi
}

build_libretro_prboom()
{
   cd $BASE_DIR
   if [ -d "libretro-prboom" ]; then
      echo "=== Building PRBoom ==="
      cd libretro-prboom
      make -j4 || die "Failed to build PRBoom"
      cp prboom_libretro.so libretro-prboom.so
   else
      echo "PRBoom not fetched, skipping ..."
   fi
}

build_libretro_stella()
{
   cd $BASE_DIR
   if [ -d "libretro-stella" ]; then
      echo "=== Building Stella ==="
      cd libretro-stella
      make -j4 || die "Failed to build Stella"
      cp libretro.so libretro-stella.so
   else
      echo "Stella not fetched, skipping ..."
   fi
}

build_libretro_desmume()
{
   cd $BASE_DIR
   if [ -d "libretro-desmume" ]; then
      echo "=== Building Desmume ==="
      cd libretro-desmume
      make -f Makefile.libretro -j4 || die "Failed to build Desmume"
      cp libretro.so libretro-desmume.so
   else
      echo "Desmume not fetched, skipping ..."
   fi
}

build_libretro_quicknes()
{
   cd $BASE_DIR
   if [ -d "libretro-quicknes" ]; then
      echo "=== Building QuickNES ==="
      cd libretro-quicknes/libretro
      make -j4 || die "Failed to build QuickNES"
      cp libretro.so ../libretro-quicknes.so
   else
      echo "QuickNES not fetched, skipping ..."
   fi
}

build_libretro_nestopia()
{
   cd $BASE_DIR
   if [ -d "libretro-nestopia" ]; then
      echo "=== Building Nestopia ==="
      cd libretro-nestopia/libretro
      make -j4 || die "Failed to build Nestopia"
      cp nestopia_libretro.so ../libretro-nestopia.so
   else
      echo "Nestopia not fetched, skipping ..."
   fi
}

build_libretro_tyrquake()
{
   cd $BASE_DIR
   if [ -d "libretro-tyrquake" ]; then
      echo "=== Building Tyr Quake ==="
      cd libretro-tyrquake
      make -f Makefile.libretro -j4 || die "Failed to build Tyr Quake"
      cp tyrquake_libretro.so libretro-tyrquake.so
   else
      echo "Tyr Quake not fetched, skipping ..."
   fi
}

build_libretro_bsnes
build_libretro_mednafen
build_libretro_s9x
build_libretro_s9x_next
build_libretro_genplus
build_libretro_fba
build_libretro_vba
build_libretro_bnes
build_libretro_fceu
build_libretro_gambatte
build_libretro_meteor
build_libretro_nx
build_libretro_prboom
build_libretro_stella
build_libretro_desmume
build_libretro_quicknes
build_libretro_nestopia
build_libretro_tyrquake

