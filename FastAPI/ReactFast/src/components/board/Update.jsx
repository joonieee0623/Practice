import { useEffect, useState } from "react"
import { Link, useNavigate, useParams } from "react-router"

function Update(){
  const navigate = useNavigate() //페이지 이동을 위한 Hook

  const [name, setName] = useState('')
  const [subject, setSubject] = useState('')
  const [content, setContent] = useState('')

  const params = useParams()
  const requestUrl = `http://localhost:8080/reboards/${params.idx}`
  useEffect(()=>{
    fetch(requestUrl) 
    .then(resObj => resObj.json())
    .then(jsObj => {
      console.log('Update jsObj:', jsObj)
      setName(jsObj.name) 
      setSubject(jsObj.subject)
      setContent(jsObj.content)
    })
  }, [])

  return(<>
    <header>
      <h2>게시판-수정</h2>
    </header>
    <nav>
      <Link to='/list'>목록</Link>
    </nav>
    <article>
    <form onSubmit={e => {
      e.preventDefault()
      fetch(requestUrl, {
        method: 'PUT',
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
        console.log('Update jsObj:', jsObj)
        navigate(`/content/${params.idx}`)
      })
    }}>
      <table id="boardTable">
        <tbody>
          <tr>
            <th>이름</th>
            <td><input name="writer" value={name} onChange={e=>{
              setName(e.target.value)
            }}/></td>
          </tr>
          <tr>
            <th>제목</th>
            <td><input name="title" value={subject} onChange={e=>{
              setSubject(e.target.value)
            }}/></td>
          </tr>
          <tr>
            <th>내용</th>
            <td>
              <textarea name="content" col="22" rows="3" value={content} 
                onChange={e => {
                  setContent(e.target.value)
                }}/>
            </td>
          </tr>
        </tbody>
      </table>
      <input type="submit" value="수정"/>
    </form>
    </article>
  </>)
}
export default Update