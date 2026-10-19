import { useState } from "react"

const ContentComp = (props) => {
  return(
    <>
      <ol>
        <li>학습</li>
        <ul>
          {props.data.study.map((item, i) => <li key={i}>{item}</li>)}
        </ul>
        <li>취미</li>
        <ul>
          {props.data.hobby.map((item, i) => <li key={i}>{item}</li>)}
        </ul>
      </ol>
    </>
  )
}


function App(){
  const [items, setItems] = useState({
    study: ['Python', 'Maria', 'Django', 'React'],
    hobby: ['수영', '헬스', '여행', '주짓수']
  })

  const addStudy = () => {    // 이렇게 하면 안됨!
    items.study.push('AWS')
    setItems(items)
  }
  const addHobby = () => {    // 이렇게 해야 함
    const newHobby = [...items.hobby, '게임']
    const newItem = {...items, hobby: newHobby}
    setItems(newItem)
  }

  return (
  <>
    <h2>React-아이템추가</h2>  //부모에서자식
      <ContentComp data={items}/>
      <button type="button" onClick={addStudy}>학습아이템추가</button>
      <button type="button" onClick={addHobby}>취미아이템추가</button>
  </>
  )
}

export default App