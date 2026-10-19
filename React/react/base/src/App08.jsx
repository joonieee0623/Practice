import react from './assets/react.svg'
import maria from './assets/maria.png'

function App(){
    const localStyle = {color:'white', backgroundColor:'green'}
    const imgStyle = {maxHeight:'30px'}
    return(<>
        <h2>React-스타일/스테이틱</h2>
        <ol>
            <li className="hobby">취미</li>
            <ul>
                <li id="hobbySub">수영</li>
                <li className="warnings">헬쓰</li>
                <li style={{color:'white', backgroundColor:'blue'}}>여행</li>
                <li style={localStyle}>주짓수</li>
            </ul>

            <li style={{color:'red'}}>학습</li>
            <ul>
                <li><img src={react} style={{maxHeight:'20px'}}/></li>
                <li><img src={maria} style={imgStyle}/></li>
                <li><img src="http://nakja.co.kr/images/reactjs.png" style={imgStyle}/></li>
            </ul>
        </ol>
    </>)
}
export default App