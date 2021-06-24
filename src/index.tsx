import { requireNativeComponent, ViewStyle } from 'react-native';

type CachedBobProps = {
  uri: string;
  priority: string;
  style: ViewStyle;
};

export const CachedBobViewManager =
  requireNativeComponent<CachedBobProps>('CachedBobView');

export default CachedBobViewManager;
