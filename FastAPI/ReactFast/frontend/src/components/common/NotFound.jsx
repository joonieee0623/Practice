import { Link } from "react-router"

function NotFound(){
  return(<>
    <h2>Not Found</h2>
    <p>
      페이지를 찾을 수 없어요 ㅠㅠ ( 잘못된 URL인 것 같아요 ^^;; )
      <br/><br/><br/>
      <Link to="/list">목록</Link>
    </p>
  </>)
}
export default NotFound