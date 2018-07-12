
int main(int argc, char**argv) {
  int res = 0;
  for (int i = 0; i < 1000000; i++) res += i + argc*res;
  return res;
}

