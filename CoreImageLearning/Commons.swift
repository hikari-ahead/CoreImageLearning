//
//  Commons.swift
//  CoreImageLearning
//
//  Created by resober on 2019/4/30.
//  Copyright © 2019 resober. All rights reserved.
//

import Foundation

enum FilterNames:String {
    typealias RawValue = String
    case CIOriginal = "Original"
    case CIBoxBlur = "CIBoxBlur"
    case CIDiscBlur = "CIDiscBlur"
    case CIGaussianBlur = "CIGaussianBlur"
    case CIMaskedVariableBlur = "CIMaskedVariableBlur"
    case CIMedianFilter = "CIMedianFilter"
    case CIMotionBlur = "CIMotionBlur"
    case CINoiseReduction = "CINoiseReduction"
    case CIZoomBlur = "CIZoomBlur"
    case CIColorClamp = "CIColorClamp"
    case CIColorControls = "CIColorControls"
    case CIColorMatrix = "CIColorMatrix"
    case CIColorPolynomial = "CIColorPolynomial"
    case CIExposureAdjust = "CIExposureAdjust"
    case CIGammaAdjust = "CIGammaAdjust"
    case CIHueAdjust = "CIHueAdjust"
    case CILinearToSRGBToneCurve = "CILinearToSRGBToneCurve"
    case CISRGBToneCurveToLinear = "CISRGBToneCurveToLinear"
    case CITemperatureAndTint = "CITemperatureAndTint"
    case CIToneCurve = "CIToneCurve"
    case CIVibrance = "CIVibrance"
    case CIWhitePointAdjust = "CIWhitePointAdjust"
    case CIColorCrossPolynomial = "CIColorCrossPolynomial"
    case CIColorCube = "CIColorCube"
    case CIColorCubeWithColorSpace = "CIColorCubeWithColorSpace"
    case CIColorInvert = "CIColorInvert"
    case CIColorMap = "CIColorMap"
    case CIColorMonochrome = "CIColorMonochrome"
    case CIColorPosterize = "CIColorPosterize"
    case CIFalseColor = "CIFalseColor"
    case CIMaskToAlpha = "CIMaskToAlpha"
    case CIMaximumComponent = "CIMaximumComponent"
    case CIMinimumComponent = "CIMinimumComponent"
    case CIPhotoEffectChrome = "CIPhotoEffectChrome"
    case CIPhotoEffectFade = "CIPhotoEffectFade"
    case CIPhotoEffectInstant = "CIPhotoEffectInstant"
    case CIPhotoEffectMono = "CIPhotoEffectMono"
    case CIPhotoEffectNoir = "CIPhotoEffectNoir"
    case CIPhotoEffectProcess = "CIPhotoEffectProcess"
    case CIPhotoEffectTonal = "CIPhotoEffectTonal"
    case CIPhotoEffectTransfer = "CIPhotoEffectTransfer"
    case CISepiaTone = "CISepiaTone"
    case CIVignette = "CIVignette"
    case CIVignetteEffect = "CIVignetteEffect"
    case CIAdditionCompositing = "CIAdditionCompositing"
    case CIColorBlendMode = "CIColorBlendMode"
    case CIColorBurnBlendMode = "CIColorBurnBlendMode"
    case CIColorDodgeBlendMode = "CIColorDodgeBlendMode"
    case CIDarkenBlendMode = "CIDarkenBlendMode"
    case CIDifferenceBlendMode = "CIDifferenceBlendMode"
    case CIDivideBlendMode = "CIDivideBlendMode"
    case CIExclusionBlendMode = "CIExclusionBlendMode"
    case CIHardLightBlendMode = "CIHardLightBlendMode"
    case CIHueBlendMode = "CIHueBlendMode"
    case CILightenBlendMode = "CILightenBlendMode"
    case CILinearBurnBlendMode = "CILinearBurnBlendMode"
    case CILinearDodgeBlendMode = "CILinearDodgeBlendMode"
    case CILuminosityBlendMode = "CILuminosityBlendMode"
    case CIMaximumCompositing = "CIMaximumCompositing"
    case CIMinimumCompositing = "CIMinimumCompositing"
    case CIMultiplyBlendMode = "CIMultiplyBlendMode"
    case CIMultiplyCompositing = "CIMultiplyCompositing"
    case CIOverlayBlendMode = "CIOverlayBlendMode"
    case CIPinLightBlendMode = "CIPinLightBlendMode"
    case CISaturationBlendMode = "CISaturationBlendMode"
    case CIScreenBlendMode = "CIScreenBlendMode"
    case CISoftLightBlendMode = "CISoftLightBlendMode"
    case CISourceAtopCompositing = "CISourceAtopCompositing"
    case CISourceInCompositing = "CISourceInCompositing"
    case CISourceOutCompositing = "CISourceOutCompositing"
    case CISourceOverCompositing = "CISourceOverCompositing"
    case CISubtractBlendMode = "CISubtractBlendMode"
    case CIBumpDistortion = "CIBumpDistortion"
    case CIBumpDistortionLinear = "CIBumpDistortionLinear"
    case CICircleSplashDistortion = "CICircleSplashDistortion"
    case CICircularWrap = "CICircularWrap"
    case CIDroste = "CIDroste"
    case CIDisplacementDistortion = "CIDisplacementDistortion"
    case CIGlassDistortion = "CIGlassDistortion"
    case CIGlassLozenge = "CIGlassLozenge"
    case CIHoleDistortion = "CIHoleDistortion"
    case CILightTunnel = "CILightTunnel"
    case CIPinchDistortion = "CIPinchDistortion"
    case CIStretchCrop = "CIStretchCrop"
    case CITorusLensDistortion = "CITorusLensDistortion"
    case CITwirlDistortion = "CITwirlDistortion"
    case CIVortexDistortion = "CIVortexDistortion"
    case CIAztecCodeGenerator = "CIAztecCodeGenerator"
    case CICheckerboardGenerator = "CICheckerboardGenerator"
    case CICode128BarcodeGenerator = "CICode128BarcodeGenerator"
    case CIConstantColorGenerator = "CIConstantColorGenerator"
    case CILenticularHaloGenerator = "CILenticularHaloGenerator"
    case CIPDF417BarcodeGenerator = "CIPDF417BarcodeGenerator"
    case CIQRCodeGenerator = "CIQRCodeGenerator"
    case CIRandomGenerator = "CIRandomGenerator"
    case CIStarShineGenerator = "CIStarShineGenerator"
    case CIStripesGenerator = "CIStripesGenerator"
    case CISunbeamsGenerator = "CISunbeamsGenerator"
    case CIAffineTransform = "CIAffineTransform"
    case CICrop = "CICrop"
    case CILanczosScaleTransform = "CILanczosScaleTransform"
    case CIPerspectiveCorrection = "CIPerspectiveCorrection"
    case CIPerspectiveTransform = "CIPerspectiveTransform"
    case CIPerspectiveTransformWithExtent = "CIPerspectiveTransformWithExtent"
    case CIStraightenFilter = "CIStraightenFilter"
    case CIGaussianGradient = "CIGaussianGradient"
    case CILinearGradient = "CILinearGradient"
    case CIRadialGradient = "CIRadialGradient"
    case CISmoothLinearGradient = "CISmoothLinearGradient"
    case CICircularScreen = "CICircularScreen"
    case CICMYKHalftone = "CICMYKHalftone"
    case CIDotScreen = "CIDotScreen"
    case CIHatchedScreen = "CIHatchedScreen"
    case CILineScreen = "CILineScreen"
    case CIAreaAverage = "CIAreaAverage"
    case CIAreaHistogram = "CIAreaHistogram"
    case CIRowAverage = "CIRowAverage"
    case CIColumnAverage = "CIColumnAverage"
    case CIHistogramDisplayFilter = "CIHistogramDisplayFilter"
    case CIAreaMaximum = "CIAreaMaximum"
    case CIAreaMinimum = "CIAreaMinimum"
    case CIAreaMaximumAlpha = "CIAreaMaximumAlpha"
    case CIAreaMinimumAlpha = "CIAreaMinimumAlpha"
    case CISharpenLuminance = "CISharpenLuminance"
    case CIUnsharpMask = "CIUnsharpMask"
    case CIBlendWithAlphaMask = "CIBlendWithAlphaMask"
    case CIBlendWithMask = "CIBlendWithMask"
    case CIBloom = "CIBloom"
    case CIComicEffect = "CIComicEffect"
    case CIConvolution3X3 = "CIConvolution3X3"
    case CIConvolution5X5 = "CIConvolution5X5"
    case CIConvolution7X7 = "CIConvolution7X7"
    case CIConvolution9Horizontal = "CIConvolution9Horizontal"
    case CIConvolution9Vertical = "CIConvolution9Vertical"
    case CICrystallize = "CICrystallize"
    case CIDepthOfField = "CIDepthOfField"
    case CIEdges = "CIEdges"
    case CIEdgeWork = "CIEdgeWork"
    case CIGloom = "CIGloom"
    case CIHeightFieldFromMask = "CIHeightFieldFromMask"
    case CIHexagonalPixellate = "CIHexagonalPixellate"
    case CIHighlightShadowAdjust = "CIHighlightShadowAdjust"
    case CILineOverlay = "CILineOverlay"
    case CIPixellate = "CIPixellate"
    case CIPointillize = "CIPointillize"
    case CIShadedMaterial = "CIShadedMaterial"
    case CISpotColor = "CISpotColor"
    case CISpotLight = "CISpotLight"
    case CIAffineClamp = "CIAffineClamp"
    case CIAffineTile = "CIAffineTile"
    case CIEightfoldReflectedTile = "CIEightfoldReflectedTile"
    case CIFourfoldReflectedTile = "CIFourfoldReflectedTile"
    case CIFourfoldRotatedTile = "CIFourfoldRotatedTile"
    case CIFourfoldTranslatedTile = "CIFourfoldTranslatedTile"
    case CIGlideReflectedTile = "CIGlideReflectedTile"
    case CIKaleidoscope = "CIKaleidoscope"
    case CIOpTile = "CIOpTile"
    case CIParallelogramTile = "CIParallelogramTile"
    case CIPerspectiveTile = "CIPerspectiveTile"
    case CISixfoldReflectedTile = "CISixfoldReflectedTile"
    case CISixfoldRotatedTile = "CISixfoldRotatedTile"
    case CITriangleKaleidoscope = "CITriangleKaleidoscope"
    case CITriangleTile = "CITriangleTile"
    case CITwelvefoldReflectedTile = "CITwelvefoldReflectedTile"
    case CIAccordionFoldTransition = "CIAccordionFoldTransition"
    case CIBarsSwipeTransition = "CIBarsSwipeTransition"
    case CICopyMachineTransition = "CICopyMachineTransition"
    case CIDisintegrateWithMaskTransition = "CIDisintegrateWithMaskTransition"
    case CIDissolveTransition = "CIDissolveTransition"
    case CIFlashTransition = "CIFlashTransition"
    case CIModTransition = "CIModTransition"
    case CIPageCurlTransition = "CIPageCurlTransition"
    case CIPageCurlWithShadowTransition = "CIPageCurlWithShadowTransition"
    case CIRippleTransition = "CIRippleTransition"
    case CISwipeTransition = "CISwipeTransition"
}

let gFilterNamesArray = [
    FilterNames.CIOriginal,
    FilterNames.CIBoxBlur,
    FilterNames.CIDiscBlur,
    FilterNames.CIGaussianBlur,
    FilterNames.CIMaskedVariableBlur,
    FilterNames.CIMedianFilter,
    FilterNames.CIMotionBlur,
    FilterNames.CINoiseReduction,
    FilterNames.CIZoomBlur,
    FilterNames.CIColorClamp,
    FilterNames.CIColorControls,
    FilterNames.CIColorMatrix,
    FilterNames.CIColorPolynomial,
    FilterNames.CIExposureAdjust,
    FilterNames.CIGammaAdjust,
    FilterNames.CIHueAdjust,
    FilterNames.CILinearToSRGBToneCurve,
    FilterNames.CISRGBToneCurveToLinear,
    FilterNames.CITemperatureAndTint,
    FilterNames.CIToneCurve,
    FilterNames.CIVibrance,
    FilterNames.CIWhitePointAdjust,
    FilterNames.CIColorCrossPolynomial,
    FilterNames.CIColorCube,
    FilterNames.CIColorCubeWithColorSpace,
    FilterNames.CIColorInvert,
    FilterNames.CIColorMap,
    FilterNames.CIColorMonochrome,
    FilterNames.CIColorPosterize,
    FilterNames.CIFalseColor,
    FilterNames.CIMaskToAlpha,
    FilterNames.CIMaximumComponent,
    FilterNames.CIMinimumComponent,
    FilterNames.CIPhotoEffectChrome,
    FilterNames.CIPhotoEffectFade,
    FilterNames.CIPhotoEffectInstant,
    FilterNames.CIPhotoEffectMono,
    FilterNames.CIPhotoEffectNoir,
    FilterNames.CIPhotoEffectProcess,
    FilterNames.CIPhotoEffectTonal,
    FilterNames.CIPhotoEffectTransfer,
    FilterNames.CISepiaTone,
    FilterNames.CIVignette,
    FilterNames.CIVignetteEffect,
    FilterNames.CIAdditionCompositing,
    FilterNames.CIColorBlendMode,
    FilterNames.CIColorBurnBlendMode,
    FilterNames.CIColorDodgeBlendMode,
    FilterNames.CIDarkenBlendMode,
    FilterNames.CIDifferenceBlendMode,
    FilterNames.CIDivideBlendMode,
    FilterNames.CIExclusionBlendMode,
    FilterNames.CIHardLightBlendMode,
    FilterNames.CIHueBlendMode,
    FilterNames.CILightenBlendMode,
    FilterNames.CILinearBurnBlendMode,
    FilterNames.CILinearDodgeBlendMode,
    FilterNames.CILuminosityBlendMode,
    FilterNames.CIMaximumCompositing,
    FilterNames.CIMinimumCompositing,
    FilterNames.CIMultiplyBlendMode,
    FilterNames.CIMultiplyCompositing,
    FilterNames.CIOverlayBlendMode,
    FilterNames.CIPinLightBlendMode,
    FilterNames.CISaturationBlendMode,
    FilterNames.CIScreenBlendMode,
    FilterNames.CISoftLightBlendMode,
    FilterNames.CISourceAtopCompositing,
    FilterNames.CISourceInCompositing,
    FilterNames.CISourceOutCompositing,
    FilterNames.CISourceOverCompositing,
    FilterNames.CISubtractBlendMode,
    FilterNames.CIBumpDistortion,
    FilterNames.CIBumpDistortionLinear,
    FilterNames.CICircleSplashDistortion,
    FilterNames.CICircularWrap,
    FilterNames.CIDroste,
    FilterNames.CIDisplacementDistortion,
    FilterNames.CIGlassDistortion,
    FilterNames.CIGlassLozenge,
    FilterNames.CIHoleDistortion,
    FilterNames.CILightTunnel,
    FilterNames.CIPinchDistortion,
    FilterNames.CIStretchCrop,
    FilterNames.CITorusLensDistortion,
    FilterNames.CITwirlDistortion,
    FilterNames.CIVortexDistortion,
    FilterNames.CIAztecCodeGenerator,
    FilterNames.CICheckerboardGenerator,
    FilterNames.CICode128BarcodeGenerator,
    FilterNames.CIConstantColorGenerator,
    FilterNames.CILenticularHaloGenerator,
    FilterNames.CIPDF417BarcodeGenerator,
    FilterNames.CIQRCodeGenerator,
    FilterNames.CIRandomGenerator,
    FilterNames.CIStarShineGenerator,
    FilterNames.CIStripesGenerator,
    FilterNames.CISunbeamsGenerator,
    FilterNames.CIAffineTransform,
    FilterNames.CICrop,
    FilterNames.CILanczosScaleTransform,
    FilterNames.CIPerspectiveCorrection,
    FilterNames.CIPerspectiveTransform,
    FilterNames.CIPerspectiveTransformWithExtent,
    FilterNames.CIStraightenFilter,
    FilterNames.CIGaussianGradient,
    FilterNames.CILinearGradient,
    FilterNames.CIRadialGradient,
    FilterNames.CISmoothLinearGradient,
    FilterNames.CICircularScreen,
    FilterNames.CICMYKHalftone,
    FilterNames.CIDotScreen,
    FilterNames.CIHatchedScreen,
    FilterNames.CILineScreen,
    FilterNames.CIAreaAverage,
    FilterNames.CIAreaHistogram,
    FilterNames.CIRowAverage,
    FilterNames.CIColumnAverage,
    FilterNames.CIHistogramDisplayFilter,
    FilterNames.CIAreaMaximum,
    FilterNames.CIAreaMinimum,
    FilterNames.CIAreaMaximumAlpha,
    FilterNames.CIAreaMinimumAlpha,
    FilterNames.CISharpenLuminance,
    FilterNames.CIUnsharpMask,
    FilterNames.CIBlendWithAlphaMask,
    FilterNames.CIBlendWithMask,
    FilterNames.CIBloom,
    FilterNames.CIComicEffect,
    FilterNames.CIConvolution3X3,
    FilterNames.CIConvolution5X5,
    FilterNames.CIConvolution7X7,
    FilterNames.CIConvolution9Horizontal,
    FilterNames.CIConvolution9Vertical,
    FilterNames.CICrystallize,
    FilterNames.CIDepthOfField,
    FilterNames.CIEdges,
    FilterNames.CIEdgeWork,
    FilterNames.CIGloom,
    FilterNames.CIHeightFieldFromMask,
    FilterNames.CIHexagonalPixellate,
    FilterNames.CIHighlightShadowAdjust,
    FilterNames.CILineOverlay,
    FilterNames.CIPixellate,
    FilterNames.CIPointillize,
    FilterNames.CIShadedMaterial,
    FilterNames.CISpotColor,
    FilterNames.CISpotLight,
    FilterNames.CIAffineClamp,
    FilterNames.CIAffineTile,
    FilterNames.CIEightfoldReflectedTile,
    FilterNames.CIFourfoldReflectedTile,
    FilterNames.CIFourfoldRotatedTile,
    FilterNames.CIFourfoldTranslatedTile,
    FilterNames.CIGlideReflectedTile,
    FilterNames.CIKaleidoscope,
    FilterNames.CIOpTile,
    FilterNames.CIParallelogramTile,
    FilterNames.CIPerspectiveTile,
    FilterNames.CISixfoldReflectedTile,
    FilterNames.CISixfoldRotatedTile,
    FilterNames.CITriangleKaleidoscope,
    FilterNames.CITriangleTile,
    FilterNames.CITwelvefoldReflectedTile,
    FilterNames.CIAccordionFoldTransition,
    FilterNames.CIBarsSwipeTransition,
    FilterNames.CICopyMachineTransition,
    FilterNames.CIDisintegrateWithMaskTransition,
    FilterNames.CIDissolveTransition,
    FilterNames.CIFlashTransition,
    FilterNames.CIModTransition,
    FilterNames.CIPageCurlTransition,
    FilterNames.CIPageCurlWithShadowTransition,
    FilterNames.CIRippleTransition,
    FilterNames.CISwipeTransition
];

