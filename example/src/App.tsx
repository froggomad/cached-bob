import * as React from 'react';

import { StyleSheet, View } from 'react-native';
import CachedBobViewManager from 'cached-bob';

export default function App() {
  return (
    <View style={styles.container}>
      <CachedBobViewManager
        priority="low"
        uri="https://i.imgur.com/6HsJHe9.jpeg"
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
