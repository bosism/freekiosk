/**
 * ESP710 - Color Palette
 * Centralized color system for consistent UI.
 * ESP710 skin: true-black background, near-black surfaces, light grey text and an amber
 * accent, matching the Stealth Ops palette of the ESP710 QGroundControl build so the
 * kiosk shell and the ground-control app it hosts look like one device.
 */

export const Colors = {
  // Primary accent (amber, same as QGC-Stealth primaryButton / buttonHighlight)
  primary: '#f0b429',
  primaryLight: '#2a2410',
  primaryDark: '#c48f14',

  // Secondary accent
  secondary: '#8bc34a',
  secondaryLight: '#1c2814',
  secondaryDark: '#5a7a35',

  // Status colors
  success: '#8bc34a',
  successLight: '#1c2814',
  successDark: '#5a7a35',

  warning: '#f0b429',
  warningLight: '#3a2a08',
  warningDark: '#c48f14',

  error: '#ff4b4b',
  errorLight: '#3a1414',
  errorDark: '#b32020',

  info: '#f0b429',
  infoLight: '#2a2410',
  infoDark: '#c48f14',

  // Neutral colors (black background, near-black surfaces)
  background: '#000000',
  surface: '#121517',
  surfaceVariant: '#1a1d20',

  // Text colors (light grey on black)
  textPrimary: '#d9dde1',
  textSecondary: '#a0a8b0',
  textHint: '#7d868e',
  textDisabled: '#4a545c',
  textOnPrimary: '#0a0c0e',

  // Border colors
  border: '#2b3239',
  borderLight: '#1f2429',
  divider: '#2b3239',

  // Specific UI elements
  switchTrackOff: '#2b3239',
  switchTrackOn: '#8c6a1a',
  switchThumbOff: '#d9dde1',

  // Shadows
  shadow: '#000000',

  // Tab specific
  tabActive: '#f0b429',
  tabInactive: '#7d868e',
  tabIndicator: '#f0b429',

  // Card backgrounds by type
  cardDefault: '#121517',
  cardInfo: '#2a2410',
  cardWarning: '#3a2a08',
  cardError: '#3a1414',
  cardSuccess: '#1c2814',
};

export type ColorKey = keyof typeof Colors;

export default Colors;
