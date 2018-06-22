/*

    Copyright (C) 2010 Oeyvind Brandtsegg and Partikkelaudio.com

    This file is part of the Hadron Particle Synthesizer.

    The Hadron Particle Synthesizer is free software; you can redistribute it
    and/or modify it under the terms of the GNU Lesser General Public
    License, version 3.0, as published by the Free Software Foundation.

    Hadron Particle Synthesizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with Hadron Particle Synthesizer; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
    02111-1307 USA
*/

#define interpolateMaskingTable(T)#
; Hyper Vectorial Synthesis used to morph between masking tables (each preset slot has separate masking tables)
        iOutTab         = $T.                   ; table to write interpolated values to
        iSnapTab        = $T._Master            ; preset values to be interpolated stored in the master preset table
        iMaskSize       = giMaskSize
        ; [, iConfigTab]                        ; could set interpolation method separately for each parameter here
                        hvs2 kx, ky, iMaskSize, inumPointsX, inumPointsY, iOutTab, iPositionsTab, iSnapTab ;[, iConfigTab]
#

#define interpolateMaskAndModscale(N) #
; interpolate (morph) masking tables
$interpolateMaskingTable(gidisttab$N.)
$interpolateMaskingTable(gifreqstartmasks$N._A)
$interpolateMaskingTable(gifreqstartmasks$N._B)
$interpolateMaskingTable(gifreqendmasks$N._A)
$interpolateMaskingTable(gifreqendmasks$N._B)
$interpolateMaskingTable(gifmampmasks$N._A)
$interpolateMaskingTable(gifmampmasks$N._B)
$interpolateMaskingTable(gigainmasks$N._A)
$interpolateMaskingTable(gigainmasks$N._B)
$interpolateMaskingTable(gichannelmasks$N._A)
$interpolateMaskingTable(gichannelmasks$N._B)
$interpolateMaskingTable(giwavemasks$N._A)
$interpolateMaskingTable(giwavemasks$N._B)

; interpolate ModScale (modulation matrix) table
                        hvs2 kx, ky, giNumModulators*giNumParameters, inumPointsX, inumPointsY, giModScale$N., iPositionsTab, giModScale$N._Master ;[, iConfigTab]

#

#define interpolateModfuncTable(T)#
; Hyper Vectorial Synthesis used to morph between modulator transfer function tables (each preset slot has separate modfunc tables)
        iOutTab         = $T.                   ; table to write interpolated values to
        iSnapTab        = $T._Master            ; preset values to be interpolated stored in the master preset table
        iFuncSize       = giModFuncSize
        ; [, iConfigTab]                        ; could set interpolation method separately for each parameter here
                        hvs2 kx, ky, iFuncSize, inumPointsX, inumPointsY, iOutTab, iPositionsTab, iSnapTab ;[, iConfigTab]
#

; ***********************************
        kupdate metro giInterpolRate
        if kupdate == 0 kgoto skip_hvs                  ; try to optimize CPU usage for hvs interpolation of presets

; Hyper Vectorial Synthesis used to interpolate between 4 presets
        kx              chnget "presetX"        ; interpolation index X axis
        ky              chnget "presetY"        ; interpolation index X axis
        kx              limit kx, 0.0, 1.0      ; test, if not limited, the plugin device may crash
        ky              limit ky, 0.0, 1.0      ; test, if not limited, the plugin device may crash
        ;printk2 kx, 0
        ;printk2 ky, 20
        inumParms       = giNumParameters       ; number of parameters in one single preset
        inumPointsX     = 2                     ; number of single presets along X axis
        inumPointsY     = 2                     ; number of single presets along Y axis
        iOutTab         = giSinglePreset        ; table to write interpolated values to
        iPositionsTab   = giPresetPos           ; 2D organisation of presets (default: one in each corner of the 2D space)
        iSnapTab        = giMasterPreset        ; preset values to be interpolated stored in the master preset table
        ; [, iConfigTab]                        ; could set interpolation method separately for each parameter here
                        hvs2 kx, ky, inumParms, inumPointsX, inumPointsY, iOutTab, iPositionsTab, iSnapTab ;[, iConfigTab]


$interpolateMaskAndModscale(1)
$interpolateModfuncTable(giModTransFunc1)
$interpolateModfuncTable(giModTransFunc2)
$interpolateModfuncTable(giModTransFunc3)
$interpolateModfuncTable(giModTransFunc4)

skip_hvs:
                chnset  kupdate, "maskTableForceUpdate" ; force update mask morfing functions when hvs interpolation is executed
                                                        ; (since this is triggered by the metro signal it should be placed outside the skip_hvs conditional)
; ***********************************

