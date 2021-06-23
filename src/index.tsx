import { requireNativeComponent, ViewStyle } from 'react-native';

type CachedBobProps = {
  color: string;
  style: ViewStyle;
};

export const CachedBobViewManager = requireNativeComponent<CachedBobProps>(
'CachedBobView'
);

export default CachedBobViewManager;
