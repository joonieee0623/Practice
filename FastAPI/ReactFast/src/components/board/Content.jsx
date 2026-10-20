import { useEffect, useState } from "react"
import { Link, useNavigate, useParams } from "react-router"

function Content(){
  const navigate = useNavigate() //페이지 이동을 위한 Hook

  const [selectRow, setSelectRow] = useState({})

  const params = useParams()
  const requestUrl = `http://localhost:8080/reboards/${params.idx}`
  useEffect(()=>{
    fetch(requestUrl) 
    .then(resObj => resObj.json())
    .then(jsObj => {
      console.log('Content jsObj:', jsObj)
      setSelectRow(jsObj) 
    })
  }, [])

  return(<>
    <header>
      <h2>게시판-상세</h2>
    </header>
    <nav>
      <Link to='/list'>목록</Link>
      <Link to={`/update/${params.idx}`}>수정</Link>
      <Link onClick={() => {
        if(window.confirm('삭제할까요?')){
          fetch(`http://localhost:8080/reboards/${params.idx}`, {
            method: 'DELETE'
          })
          .then(resObj => resObj.json())
          .then(jsObj => {
            //console.log('Content jsObj:', jsObj)
            console.log('Content jsObj.result:', jsObj.result)
            if(jsObj.result){
              navigate('/list') 
            }else{
              alert('삭제 실패')  
            }
          })
        }
      }}>삭제</Link>
    </nav>
    <article>
      <table id="boardTable">
        <colgroup>
          <col width="20%"/>
          <col width="*"/>
        </colgroup>
        <tbody>
          <tr>
            <th>번호</th>
            <td>{selectRow.idx}</td>
          </tr>
          <tr>
            <th>이름</th>
            <td>{selectRow.name}</td>
          </tr>
          <tr>
            <th>제목</th>
            <td>{selectRow.subject}</td>
          </tr>
          <tr>
            <th>내용</th>
            <td>{selectRow.content}</td>
          </tr>
          <tr>
            <th>내용(원본)</th>
            <td style={{whiteSpace:'pre-wrap'}}>
              {selectRow.content}
            </td>
          </tr>
          <tr>
            <th>날짜</th>
            <td>{selectRow.regdate}</td>
          </tr>
        </tbody>
      </table>
    </article>
  </>)
}
export default Content