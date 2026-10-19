function App(){
  return (
    <>
      <h2>Readct-기본</h2>
      <ol>
        <li>학습</li>
        <ul>
          <li>Python</li>
          <li>Maria</li>
          <li>Django</li>
          <li>React</li>
        </ul>
        <li>취미</li>
        <ul>
          <li>수영</li>
          <li>헬스</li>
          <li>여행</li>
          <li>주짓수</li>
        </ul>
      </ol>
      <form>
        <select name="gubun">
          <option value="study">학습</option>
          <option value="hobby">취미</option>
        </select>
        <input type="text" name="title"/>
        <input type="submit" value="추가"/>
      </form>
    </>
  )
}

export default App