using Data;
using DataModels;

namespace Logic
{
    public interface ILogicIngredient
    {
        ResponseObject<ResponseObjectIngredientBase>  CreateIngredient(IngredientBase ingredient);
        ResponseObject<object>  DeleteIngredient(int ingredientId);
        ResponseObject<ResponseObjectListIngredientBase>  RetrieveIngredients();
        ResponseObject<ResponseObjectIngredientBase>  UpdateIngredient(IngredientBase ingredient);
    } // end interface

    public class LogicIngredient(IDataIngredient dataIngredient) : LogicBase, ILogicIngredient
    {
        public ResponseObject<ResponseObjectIngredientBase>  CreateIngredient(IngredientBase ingredient)
        {
            try
            {
                return new ResponseObject<ResponseObjectIngredientBase>
                {
                    Data = new ResponseObjectIngredientBase
                    {
                        Ingredient = dataIngredient.CreateIngredient(ingredient).Result.FirstOrDefault()
                    }
                };
            }
            catch (Exception e)
            {
                return BuildErrorObject<ResponseObjectIngredientBase>(e);
            }
        } // end
        
        public ResponseObject<object> DeleteIngredient(int ingredientId)
        {
            try
            {
                dataIngredient.DeleteIngredient(ingredientId);
                
                return new ResponseObject<object>();
            }
            catch (Exception e)
            {
                return BuildErrorObject<object>(e);
            }
        } // end
        
        public ResponseObject<ResponseObjectListIngredientBase>  RetrieveIngredients()
        {
            try
            {
                var ingredients = dataIngredient.RetrieveIngredients().Result;
                
                return new ResponseObject<ResponseObjectListIngredientBase>
                {
                    Data = new ResponseObjectListIngredientBase
                    {
                        Ingredients = BuildObjectTree(ingredients.ToList())
                    }
                };
            }
            catch (Exception e)
            {
                return BuildErrorObject<ResponseObjectListIngredientBase>(e);
            }
        } // end
        
        public ResponseObject<ResponseObjectIngredientBase>  UpdateIngredient(IngredientBase ingredient)
        {
            try
            {
                return new ResponseObject<ResponseObjectIngredientBase>
                {
                    Data = new ResponseObjectIngredientBase
                    {
                        Ingredient = dataIngredient.UpdateIngredient(ingredient).Result.FirstOrDefault()
                    }
                };
            }
            catch (Exception e)
            {
                return BuildErrorObject<ResponseObjectIngredientBase>(e);
            }
        } // end
    } // end class
} // end namespace