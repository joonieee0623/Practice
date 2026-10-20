import { Route, Routes } from "react-router"
import List from "./components/board/List"
import Write from "./components/board/Write"
import Content from "./components/board/Content"
import Update from "./components/board/Update"
import NotFound from "./components/common/NotFound"
import Search from "./components/board/Search"


function App(){
  return(<>
    <Routes>
      <Route path='/' element={<List />}/>
      <Route path='/list' element={<List />}/>
      <Route path='/write' element={<Write />}/>
      {/* <Route path='/reboards'>
        <Route path=':idx' element={<Content />}/>
      </Route> */}
      <Route path='/content/:idx' element={<Content />}/>
      <Route path='/update/:idx' element={<Update />}/>
      <Route path='*' element={<NotFound />} />
      
      <Route path='/search' element={<Search/>}/>
    </Routes>
  </>)
}
export default App