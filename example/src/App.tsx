import * as React from 'react';

import { StyleSheet, View } from 'react-native';
import CachedBobViewManager from 'cached-bob';

export default function App() {
  return (
    <View style={styles.container}>
      <CachedBobViewManager
        priority="low"
        sources={[
          ['https://i.imgur.com/uxcy7TS.png', 'uxcy7TS'],
          ['https://i.imgur.com/gXdy1Vn.jpeg', 'gXdy1Vn'],
          ['https://i.imgur.com/3rrydD4.png', '3rrydD4'],
          ['https://i.imgur.com/j8HdmNz.png', 'j8HdmNz'],
        ]}
        style={styles.box}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 400,
    height: 400,
    marginVertical: 20,
  },
});
