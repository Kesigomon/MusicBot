# ビルド方法

## Wheel事前ビルドなし
Arm向けにビルドするとかでない限り、こちらの方が良いです。

```bash
docker build . -t musicbot
```

## Wheel事前ビルドあり
Arm向けにビルドするとwheelのビルドに死ぬほど時間がかかるので
それなら事前にビルドしてしまおうという魂胆。
```bash
python3 wheels/build.py
```

そのあとで
.dockerignoreの
```.ignore
wheels/
```
を消す

あとの手順はwheelを事前ビルドしない場合と同じ

# 実行
config以下をいろいろ書き換えて
```bash
docker run --rm -itd -v $PWD/config:/opt/MusicBot/config --name musicbot musicbot
```
でOK。（コマンドは環境に応じて適宜変えると良さそう）