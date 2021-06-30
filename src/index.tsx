import { requireNativeComponent, ViewStyle } from 'react-native';

type Source = [string, string];

type CachedBobProps = {
  sources: Source[];
  priority: string;
  style: ViewStyle;
};

export const CachedBobViewManager =
  requireNativeComponent<CachedBobProps>('CachedBobView');

export default CachedBobViewManager;
