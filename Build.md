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

そのあとで、Dockerfile内のコメントアウトを以下のように切り替える
```dockerfile
### Wheelビルドなしバージョン
### arm向けにビルドしないならこっちのほうが良いです
# RUN pip3 install -r requirements.txt
### ここまでビルドなしバージョン


### Wheelビルドありバージョン
### arm向けにビルドするならこっち
### こちらを利用する場合、あらかじめ/wheels/build.pyを実行しておくこと
COPY ./wheels/wheels /tmp/wheels
RUN pip3 install -r requirements.txt --no-index --find-links=/tmp/wheels
### ここまでビルドありバージョン
```

# 実行
config以下をいろいろ書き換えて
```bash
docker run --rm -itd -v $PWD/config:/opt/MusicBot/config --name musicbot musicbot
```
でOK。（コマンドは環境に応じて適宜変えると良さそう）