
import './App.css';
import React from 'react';
import Home from './components/Home';
import Navbar from './components/Navbar';
import Mint from './components/Mint'
import Footer from './components/Footer';


import {
  BrowserRouter as Router,
  Switch,
  Route,
} from "react-router-dom";

function App() {


  return (

         <Router basename='/'>
    <div className="App">
       <Navbar/>

      <Switch>

          <Route exact path="/">
              <Home/>
          </Route>
          <Route exact path="/Home">
              <Home/>
          </Route>

          <Route exact path="/Mint">
              <Mint/>
          </Route>
        </Switch>

      <Footer/>

    </div>
    </Router>
  )
}

export default App;
