# VIPER まとめ

## Clean Architecture (以下、CA)とは？
https://blog.tai2.net/the_clean_architecture.html
- 近年注目されているアーキテクチャで、仕様変更に強く、テスタビリティが高い
- CAとは、コレといった枠組みはなく、依存の向きが上位レベルの方針だけに向かっているルールを守っているアーキテクチャ
- 極端な話、方針（ビジネスロジック）が詳細（UI、DB、API通信）の変更に影響しない依存関係で構築されていればCAと言える  
 よく目にするCAの図（あくまでCAの一例）では、内側の円が方針、外側の円が詳細を表し、外側から内側にのみ依存できることを示している  
 そのため、自分のプロダクトにあった形式にカスタマイズするのはOK  
 また、外側の円で宣言された名前（クラス名、メソッド名、変数）は、内側の円で使ってはならない  
- CAに従っているアーキテクチャで実装することで、モジュール間の依存性が低くなる
- CAはあくまで依存関係を整理したものなので、言語やフレームワーク、ライブラリに依存しない
- CAの中でiOSアプリ開発に適したアーキテクチャの１つがVIPER

## VIPERと他のアーキテクチャ
- VIPERとは？
 https://qiita.com/YKEI_mrn/items/67735d8ebc9a83fffd29
- Apple MVCとの違いは、C（ViewController）の役割を細分化している点  
　→ VIPERはHumble Objectパターンに従っている（単体テスト難：V ⇔ 単体テスト易：IPERに分けるイメージ）  
　→ MVCのほうはMはテストしやすかったけれど、他がテストしにくい  
　 　・・・テストできる範囲がCAよりも狭く、テストしにくいVCが太りがち  
　 　VIPERでは、その太りがちなVCを分解することでテストできる項目が増え、結果的にテスタビリティが向上する  
- MVVMとの大きな違いは、外部ライブラリに依存しないこと  
 MVVMを組もうとすると、Rxライブラリがほぼ必須になる  
　→ （iOS13以降はCombineが標準搭載だが）個人的にアーキテクチャにライブラリ依存があるのは反対  
　　　そのライブラリに不具合があった場合、影響範囲が機能よりもアーキテクチャのほうが大きいため  
　→ さらに、Reactive Extensionsの学習コストが高い。そのため、MVVMの導入はどうしてもコストが高くなりがち。  
　そもそもMVVMもVCをスリムにすることが目的なので、他のアーキテクチャで十分だと思う  

## VIPERを使うべきか？
- 開発プロジェクトが短く、複雑ではない　→ NG
- 開発プロジェクトが長く、複雑　　　　　→ VIPERを使った方が良い
- それ以外　　　　　　　　　　　　　　　→ どっちでも良い

https://swifting.io/blog/2016/03/07/8-viper-to-be-or-not-to-be/

## VIPERの各種クラスの役割
- **V**iew
  - UIView + UIViewController + (Storyboard, xib)
  - Presenterから依頼される表示処理を担当
  - 表示処理以外はPresenterに処理を依頼する
- **I**nteractor
  - ビジネスロジックを担当　※1画面に1つのInteractorとは限らない
  - Presenterから依頼された処理実行し、その結果をPresenterに返す
  - Viewを知ってはいけない（UIKitのインポート＝NG）
- **P**resenter
  - View, Interactor, Routerの橋渡しを担当
  - Viewに画面の更新依頼を投げる
  - Interactorにデータの取得依頼を投げる（その結果を受け取る）
  - Routerに画面遷移の依頼を投げる
  - Viewを知ってはいけない（UIKitのインポート＝NG）
- **E**ntity
  - IntやStringなど、基本的な型のみを扱うことが望ましい
  - Viewを知ってはいけない（UIKitのインポート＝NG）
- **R**outer
  - 画面遷移を担当
  - 遷移先に必要なオブジェクト（Presenter, Interactor, View）を作成し、DIを行う
  - Viewを初期化するため、Viewを知っている（UIKitのインポート＝OK）

## VIPERの処理の流れ
<画面遷移>  
ボタン押下などのUIイベントで画面遷移する場合の処理の流れ
1. イベントキャッチ後、遷移元のViewがPresenterに画面遷移を要求
2. PresenterがRouterに画面遷移を要求
3. Routerは遷移先のRouter’に画面作成を要求
4. Router’はView’, Presenter’, Interactor’, ViewController’を作成し、ViewController’を返す
5. RouterはRouter’から受け取ったViewController’に遷移
6. 画面遷移後、View’はviewDidLoadやviewDidAppearなどをPresenter’に通知  
 このとき、必要があればPresenter’はInteractor’を使って画面表示に必要な情報を取得

<イベント処理>  
1. イベントキャッチ後、ViewはPresenterに処理を要求
2. PresenterはInteractorを実行
3. 処理完了後、InteractorからEntityを受け取る
4. PresenterはViewに画面更新を要求

## メリットとデメリット
<メリット>  
- View、Routerといった枠組み通りに実装するため、クラス構成や依存関係にあまり悩まなくてもいい  
 → ただしInteractorはSRP（単一責任の原則）とDIP（依存性逆転の原則）を意識したほうが良いと思う    
  DIPの有無によってUnitTestで使うモックの作りやすさが違う  
- VIPERの各クラスの役割が明確になっているため、比較的追いやすいと思う  
  - 画面遷移先はどこ？・・・Routerを確認  
  - ビジネスロジッククラスはどこ？・・・RouterからInteractorを探す    
  - 画面表示ロジックは？・・・ViewControllerを確認  
  Apple MVCではこれらをViewControllerやStoryboardの中から探すので大変だった。  
- 画面遷移をRouterで行うため、１つのstoryboardファイルに定義する画面数が少ない  
 → コンフリクトが起こりにくい  
- UnitTestがしやすい。その結果CIが捗り、品質が向上する。  
 → 基本的にVIPERそれぞれのクラス毎にインタフェースを用意して実装するため    
  インタフェースを実装したモックを差し込んで、挙動を確認できる  

<デメリット>
- ファイル数が多くて面倒（MVCと比べるとクラス数が多くなり、さらにインタフェースも必要になるため）  
 → テンプレートを使ったクラスの自動生成で負荷を軽減できる
- MVCからVIPERの移行はコストがかかる  
- 学習コストが高い。クラスの役割や、処理をどれに分類すればいいか悩む。そのためチームの認識合わせは必要  
  - RxSwiftでUIと変数をバインドするような処理の場合は、VCに書いて良いか？  
  → 多分VCで大丈夫なはず。PresenterはUIコンポーネントを知ってはいけないため。  
  - ViewがEntityを参照しても良いか？  
  → Clean ArchitectureではNGだが、VIPER公式のサンプルではViewがEntityを参照しているので悩む  
  とりあえずデモアプリはClean Architectureに合わせてEntityをViewModelに変換してViewに渡している。  
