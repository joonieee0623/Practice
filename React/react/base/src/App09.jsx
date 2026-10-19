import { useState } from "react"

function WriteForm(props){
    return(
        <>
        <form onSubmit={event => {
            event.preventDefault()
            let gubun = event.target.gubun.value
            let title = event.target.title.value
            props.onWrite(gubun, title)
        }}>
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

function App(){
    const [msg, setMsg] = useState('진행중...')
    return(
        <>
            <h2>React-폼</h2>  //자식에서 부모
            <WriteForm onWrite={(g, t) => {
                //console.log(`g ${g}, t: ${t}`)
                if(g !== '' && t !== ''){
                    let result = `넘겨진 값들: ${g} / ${t}`
                    setMsg(result)
                }
            }}/>

            <pre>{msg}</pre>
        </>
    )
}

export default App
