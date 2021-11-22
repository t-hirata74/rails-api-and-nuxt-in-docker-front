<template>
  <div>
    <h2>
      Usersテーブルの取得
    </h2>
    <table v-if="users.length">
      <thead>
        <tr>
          <th>id</th>
          <th>name</th>
          <th>email</th>
          <th>created_at</th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="(user, i) in users"
          :key="`user-${i}`"
        >
          <td>{{ user.id }}</td>
          <td>{{ user.name }}</td>
          <td>{{ user.email }}</td>
          <td>{{ dateFormat(user.created_at) }}</td>
        </tr>
      </tbody>
    </table>

    <div v-else>
      ユーザーが取得できませんでした
    </div>
  </div>
</template>

<script>
export default {
  // asyncData => コンポーネントデータを表示する前に実行されるメソッド
  // async => promiseを返す（promis => 非同期処理の結果を表示するオブジェクトのこと）
  // await => promiseを返すまでJavaScriptを待機させる
  async asyncData ({ $axios }) {
    let users = []
    await $axios.$get('/api/v1/users')
      .then(res => (users = res))
    return { users }
  },
  // 算出プロパティ => 計算したデータを返す関数のこと
  computed: {
    dateFormat () {
      return (date) => {
        const dateTimeFormat = new Intl.DateTimeFormat(
          'ja', { dateStyle: 'medium', timeStyle: 'short' }
        )
        return dateTimeFormat.format(new Date(date))
      }
    }
  }
}
</script>
