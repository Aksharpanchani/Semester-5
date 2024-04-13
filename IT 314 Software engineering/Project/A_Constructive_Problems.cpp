#include <iostream>
#include <vector>

using namespace std;

int main() {
    int t;
    cin >> t;

    while (t--) {
        int n, m;
        cin >> n >> m;

        int max_size = max(n, m);

        cout << max_size << endl;
    }

    return 0;
}
