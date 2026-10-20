import { useEffect, useState } from "react"
import { Link, useLocation } from "react-router"

function Search(){
  //(1) 넘겨진 Query String 데이터 받기
  //http://localhost:5173/search?subject=제목1
  //http://localhost:5173/search?name=정현영
  //http://localhost:5173/search?content=내용1
  const location = useLocation()
  const queryParams = new URLSearchParams(location.search)
  const subject = queryParams.get('subject')
  const name = queryParams.get('name')
  const content = queryParams.get('content')
  console.log(`Search subject: ${subject}, name: ${name}, content: ${content}`)

  //(2) field 와 keyword 를 셋팅
  let field = ''
  let keyword = ''
  if(subject){ //subject !== null
    field = 'subject'
    keyword = subject
  }else if(name){ //name !== null
    field = 'name'
    keyword = name
  }else if(content){ //content !== null
    field = 'content'
    keyword = content
  }
  console.log(`Search field: ${field}, keyword: ${keyword}`)

  //(3) 백엔드에 요청 
  const [searchData, setSearchData] = useState([])
  const requestUrl = `http://localhost:8080/reboards/search?${field}=${encodeURIComponent(keyword)}`
  useEffect(() => {
    if(!field || !keyword) return

    fetch(requestUrl)
    .then(resObj => resObj.json())
    .then(jsObjArr => {
      console.log('Search jsObjArr', jsObjArr)
      setSearchData(jsObjArr)
    })
    .catch(err => console.error('백엔드서버가 응답하지 않아요ㅠㅠ', err))
  })

  //(4) searchData 로 태그list 생성 
  const listTag = searchData.map(row => {
    let subject = row.subject.substring(0,20)
    let regdate = row.regdate.substring(0,10)

    return(
      <tr key={row.idx}>
        <td className="cen">{row.idx}</td>
        <td className="cen">{row.name}</td>
        <td><Link to={`/content/${row.idx}`}>{subject}</Link></td>
        <td className="cen">{regdate}</td>
      </tr>
    )
  })
  
  return(<>
    <header>
      <h2>게시판-검색결과</h2>
    </header>
    <nav>
      <Link to='/list'>목록</Link>
    </nav>
    <br/>
    <article>

    <h4>
      {/* Conditional Rendering */}
      {field === 'subject' && '제목'} 
      {field === 'name' && '이름'}
      {field === 'content' && '내용'}
      &nbsp;/ 키워드: '{keyword}'
    </h4>

    <table id="boardTable">
      <thead>
        <tr>
          <th>번호</th>
          <th>이름</th>
          <th>제목</th>
          <th>날짜</th>
        </tr>
      </thead>
      <tbody>
        {/* {listTag} */}
        {listTag.length>0 ? listTag: (
          <tr>
            <td colSpan="4" className="cen">검색결과가 없어요</td>
          </tr>
        )}
      </tbody>
    </table>
    </article>
  </>)
}
export default Search