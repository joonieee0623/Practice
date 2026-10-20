import { Link, useNavigate } from "react-router"

function Write(){
  const navigate = useNavigate() //페이지 이동을 위한 Hook

  const requestUrl = 'http://localhost:8080/reboards'
  return(<>
    <header>
      <h2>게시판-작성</h2>
    </header>
    <nav>
      <Link to='/list'>목록</Link>
    </nav>
    <article>
      <form onSubmit={e =>{
        e.preventDefault()
        fetch(requestUrl, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json', 
          }, 
          body:JSON.stringify({
            name: e.target.writer.value, 
            subject: e.target.title.value,
            content: e.target.content.value,
          }),
        })
        .then(resObj => resObj.json())
        .then(jsObj => {
          console.log('Write jsObj:', jsObj)
          navigate('/list') 
        })
      }}>
        <table id="boardTable">
          <tbody>
            <tr>
              <th>이름</th>
              <td><input type="text" name="writer"/></td>
            </tr>
            <tr>
              <th>제목</th>
              <td><input type="text" name="title"/></td>
            </tr>
            <tr>
              <th>내용</th>
              <td><textarea name="content" col="22" rows="3"/></td>
            </tr>
          </tbody>
        </table>
        <input type="submit" value="전송"/>
      </form>
    </article>
  </>)
}
export default Write